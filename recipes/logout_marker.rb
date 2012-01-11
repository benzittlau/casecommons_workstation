execute "remove-logout-required-marker" do
  action :nothing
  command "rm -f #{node[:logout_marker]}"
end

execute "touch-logout-required-marker" do
  action :nothing
  command "touch #{node[:logout_marker]}"
end

script "print-logout-banner" do
  only_if "test -e #{node[:logout_marker]}"
  action :nothing
  interpreter "ruby"
  code <<-EOS
    puts "\033[1;43m\033[2;31m*** LOGOUT REQUIRED! ***\033[0m"
    puts "*** Some changes made during this deployment will not take effect until you logout & log back in *** "
  EOS
  notifies :run, "execute[remove-logout-required-marker]", :immediately
end

