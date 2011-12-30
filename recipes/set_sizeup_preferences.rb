include_recipe "pivotal_workstation::sizeup"

template "/tmp/com.irradiatedsoftware.SizeUp.plist.xml" do
  source "com.irradiatedsoftware.SizeUp.xml.erb"
  owner WS_USER
end

execute "import-iterm-plist" do
  command "plutil -convert binary1 /tmp/com.irradiatedsoftware.SizeUp.plist.xml -o #{WS_LIBRARY}/Preferences/com.irradiatedsoftware.SizeUp.plist"
  user WS_USER
end

startup_item "/Applications/SizeUp.app"

