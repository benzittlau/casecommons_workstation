template "/Library/LaunchDaemons/com.pivotal.rebrewstrap.plist" do
  source "com.pivotal.rebrewstrap.plist.erb"
  mode "0644"
end

execute "unload-deprecated-rebrewstrap-plist" do
  only_if "test -f /Library/LaunchAgents/com.pivotal.rebrewstrap.plist"
  command "launchctl unload -w /Library/LaunchAgents/com.pivotal.rebrewstrap.plist"
end

execute "remove-deprecated-rebrewstrap-plist" do
  only_if "test -f /Library/LaunchAgents/com.pivotal.rebrewstrap.plist"
  command "rm -f /Library/LaunchAgents/com.pivotal.rebrewstrap.plist"
end

execute "unload rebrewstrap plist" do
  command "launchctl unload -w /Library/LaunchDaemons/com.pivotal.rebrewstrap.plist"
end

execute "load rebrewstrap plist" do
  command "launchctl load -w /Library/LaunchDaemons/com.pivotal.rebrewstrap.plist"
end
