execute "install-or-update-rvm" do
  environment( { "PATH" => node[:current_path] } )
  command "rvm get #{node[:rvm][:version]}"
  user WS_USER
end

execute "rvm-project-rvmrc" do
  cwd WS_HOME
  command %[grep rvm_project_rvmrc=1 ~/.rvmrc || echo "export rvm_project_rvmrc=1" >> ~/.rvmrc]
  user WS_USER
end

execute "modify-rvmrc-to-autoinstall" do
  cwd WS_HOME
  command %[grep rvm_install_on_use_flag ~/.rvmrc || echo "rvm_install_on_use_flag=1" >> ~/.rvmrc]
  user WS_USER
end


