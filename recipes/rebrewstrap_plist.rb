template "/Library/LaunchAgents/com.pivotal.rebrewstrap.plist" do
  source "com.pivotal.rebrewstrap.plist.erb"
  mode "0644"
end

execute "load rebrewstrap plist" do
  cwd "/Library/LaunchAgents"
  command "launchctl load com.pivotal.rebrewstrap.plist"
end
