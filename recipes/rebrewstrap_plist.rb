template "/Library/LaunchDaemons/com.pivotal.rebrewstrap.plist" do
  source "com.pivotal.rebrewstrap.plist.erb"
  mode "0644"
end

execute "unload-deprecated-rebrewstrap-plist" do
  only_if "test -f #{node[:rebrewstrap_plist_deprecated]}"
  command "launchctl unload -w #{node[:rebrewstrap_plist_deprecated]}"
end

execute "remove-deprecated-rebrewstrap-plist" do
  only_if "test -f #{node[:rebrewstrap_plist_deprecated]}"
  command "rm -f #{node[:rebrewstrap_plist_deprecated]}"
end

execute "unload rebrewstrap plist" do
  # only if the launchctl task isn't currently running
  not_if "sudo launchctl list | egrep \"^[0-9]+.*com.pivotal.rebrewstrap\""
  command "launchctl unload -w #{node[:rebrewstrap_plist]}"
end

execute "load rebrewstrap plist" do
  not_if "launchctl list | grep com.pivotal.rebrewstrap"
  command "launchctl load -w #{node[:rebrewstrap_plist]}"
end
