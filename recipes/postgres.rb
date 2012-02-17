include_recipe "pivotal_workstation::homebrew"
include_recipe "casecommons_workstation::sysctl"

# remove postgres marker if upgrade required - cannot do as a chef resource because run_unless method evaluates too early
if node[:postgres][:version] != `psql --version | head -n 1 | cut -f 3 -d ' '`.strip
  system "rm -f #{WS_HOME}/.install_markers/postgres"
end

run_unless_marker_file_exists("postgres") do

  plist_path = File.expand_path('org.postgresql.postgres.plist', File.join('~', 'Library', 'LaunchAgents'))
  if File.exists?(plist_path)
    log "postgres plist found at #{plist_path}"
    execute "unload the plist (shuts down the daemon)" do
      command %'launchctl unload -w #{plist_path}'
      user WS_USER
    end
  else
    log "Did not find plist at #{plist_path} don't try to unload it"
  end

#    blow away default image's data directory
  directory "/usr/local/var/postgres" do
    action :delete
    recursive true
  end

  brew_remove "postgresql"
  brew_install "postgresql", sha: node[:postgres][:sha]

  execute "create the database" do
    command %'initdb -U #{WS_USER} --encoding=utf8 --locale=en_US /usr/local/var/postgres'
    user WS_USER
  end



  launch_agents_path = File.expand_path('.', File.join('~','Library', 'LaunchAgents'))
  directory launch_agents_path do
    action :create
    recursive true
    owner WS_USER
  end


  execute "copy over the plist" do
    command %'cp /usr/local/Cellar/postgresql/9.*/*postgresql*.plist ~/Library/LaunchAgents/'
    user WS_USER
  end

  execute "start the daemon" do
    command %'launchctl load -w ~/Library/LaunchAgents/*postgresql*.plist'
    user WS_USER
  end

  ruby_block "wait four seconds for the database to start" do
    block do
      sleep 4
    end
  end

  execute "create the database" do
    command "createdb"
    user WS_USER
  end

end

template "/usr/local/var/postgres/postgresql.conf" do
  source "postgresql.conf.erb"
  owner WS_USER
  notifies :run, "execute[restart-postgres-server]"
end

execute "restart-postgres-server" do
  command %'launchctl unload -w #{WS_HOME}/Library/LaunchAgents/*postgresql*.plist && launchctl load -w #{WS_HOME}/Library/LaunchAgents/*postgresql*.plist'
  user  WS_USER
  action :nothing
end
