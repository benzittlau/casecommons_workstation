execute "make textmate bundles directory" do
  command "mkdir -p '#{WS_HOME}/.bash_profile_includes'"
  user WS_USER
  not_if { File.exists?("#{WS_HOME}/.bash_profile_includes") }
end

template "#{WS_HOME}/.bash_profile_includes/autowrite-vim.sh" do
  source "autowrite-vim.sh.erb"
  owner WS_USER
end

template "#{WS_HOME}/.bash_profile_includes/preexec.sh.lib" do
  source "preexec.sh.lib.erb"
  owner WS_USER
end

template "#{WS_HOME}/.bash_profile_includes/ps1.sh" do
  source "ps1.sh.erb"
  owner WS_USER
end
