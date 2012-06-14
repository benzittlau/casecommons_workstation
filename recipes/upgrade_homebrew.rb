execute "clean-brew-repository-if-required" do
  not_if "test `brew --version` = '#{node[:brew][:version]}'"
  command "cd `brew --prefix` && git reset --hard HEAD && git clean -f -d"
end

brew do
  not_if "test `brew --version` = '#{node[:brew][:version]}'"
  action :update
end
