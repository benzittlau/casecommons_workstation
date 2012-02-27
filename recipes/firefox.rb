check_firefox_version = "test '#{node[:firefox][:version]}' = $(/Applications/Firefox.app/Contents/MacOS/firefox -v | cut -f 3 -d ' ')"

remote_file "/tmp/firefox-#{node[:firefox][:version]}.dmg" do
  source "http://download.mozilla.org/?product=firefox-#{node[:firefox][:version]}&os=osx&lang=en-US"
  checksum node[:firefox][:checksum]
  not_if check_firefox_version
end

execute "install firefox" do
  command "hdiutil attach /tmp/firefox-#{node[:firefox][:version]}.dmg && cp -R /Volumes/Firefox/Firefox.app /Applications/ ; hdiutil detach /Volumes/Firefox"
  not_if check_firefox_version
end
