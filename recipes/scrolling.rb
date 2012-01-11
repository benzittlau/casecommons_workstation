run_unless_marker_file_exists("scrolling_direction") do
  include_recipe "casecommons_workstation::logout_marker"
  plist ".GlobalPreferences" do
    key "com.apple.swipescrolldirection"
    value false
  end

  plist "com.apple.driver.AppleBluetoothMultitouch.trackpad" do
    key "TrackpadScroll"
    value false
  end

  execute "notify user of logout" do
    command "true"
    notifies :run, "execute[touch-logout-required-marker]", :immediately
  end

end
