include_recipe "pivotal_workstation::workspace_directory"

src_directory = "#{WS_HOME}/workspace/git_scripts-peeja"

git src_directory do
  repository "git://github.com/Peeja/git_scripts.git"
  reference "master"
  action :sync
  user WS_USER
  enable_submodules true
  branch "master"
end

execute "symlink-all-git-script-binaries-to-usr-local-bin" do
  command "ln -svf #{src_directory}/bin/* /usr/local/bin/"
  user WS_USER
end
