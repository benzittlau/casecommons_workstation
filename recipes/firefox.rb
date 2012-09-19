remote_file "/tmp/firefox-#{node[:firefox][:version]}.dmg" do
  source "https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/#{node[:firefox][:version]}/mac/en-US/Firefox%20#{node[:firefox][:version]}.dmg"
  mode "0644"
  checksum node[:firefox][:checksum]
  not_if %Q{test "Mozilla Firefox #{node[:firefox][:version]}" = "`/Applications/Firefox.app/Contents/MacOS/firefox -v`"}
end

execute "install firefox" do
  command <<-SH
    hdiutil attach /tmp/firefox-#{node[:firefox][:version]}.dmg
    cp -R /Volumes/Firefox/Firefox.app /Applications/
    hdiutil detach /Volumes/Firefox
  SH
  not_if %Q{test "Mozilla Firefox #{node[:firefox][:version].delete("esr")}" = "`/Applications/Firefox.app/Contents/MacOS/firefox -v`"}
end
