include_recipe "casecommons_workstation::sysctl"
include_recipe "pivotal_workstation::homebrew"

# remove postgres marker if upgrade required - cannot do as a chef resource because run_unless method evaluates too early
if node[:postgres][:version] != `psql --version | head -n 1 | cut -f 3 -d ' '`.strip
  system "rm -f #{WS_HOME}/.install_markers/postgres"
end

run_unless_marker_file_exists("postgres") do

  plist_pattern =  File.join('~', 'Library', 'LaunchAgents','*postgres*.plist')
  if Dir[plist_pattern].any?
    log "postgres plist found at #{plist_pattern}"
    execute "unload the plist (shuts down the daemon)" do
      command %'launchctl unload -w #{plist_pattern}'
      user WS_USER
    end
  else
    log "Did not find plist at #{plist_pattern} don't try to unload it"
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

  execute "remove postgres plists from launchd" do
    command "launchctl list | cut -f 3 | grep postgres | xargs -I {} launchctl remove {}"
    user WS_USER
  end

  execute "remove the existing plists" do
    command %'rm ~/Library/LaunchAgents/*postgresql*.plist'
    user WS_USER
  end

  execute "copy over the plist" do
    command %'cp /usr/local/Cellar/postgresql/#{node[:postgres][:version]}/*postgresql*.plist ~/Library/LaunchAgents/'
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
end

script "restart-postgres-server" do
  environment({ "PATH" => node[:current_path] })
  user WS_USER
  interpreter "bash"
  code <<-SH
    launchctl unload -w #{WS_HOME}/Library/LaunchAgents/*postgresql*.plist
    sleep 5
    ps aux | grep postgres |grep -v grep| awk '{print $2}' | xargs kill
    launchctl load -w #{WS_HOME}/Library/LaunchAgents/*postgresql*.plist
  SH
end

