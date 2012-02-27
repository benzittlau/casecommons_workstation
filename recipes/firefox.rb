check_firefox_verison = %Q{test "Mozilla Firefox #{node[:firefox][:version]}" = "`/Applications/Firefox.app/Contents/MacOS/firefox -v`"}

remote_file "/tmp/firefox-#{node[:firefox][:version]}.dmg" do
  source "http://download.mozilla.org/?product=firefox-#{node[:firefox][:version]}&os=osx&lang=en-US"
  mode "0644"
  checksum node[:firefox][:checksum]
  not_if check_firefox_version
end

execute "install firefox" do
  command <<-SH
    hdiutil attach /tmp/firefox-#{node[:firefox][:version]}.dmg
    cp -R /Volumes/Firefox/Firefox.app /Applications/
    hdiutil detach /Volumes/Firefox
  SH
end
