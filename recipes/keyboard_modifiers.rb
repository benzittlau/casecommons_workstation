run_unless_marker_file_exists("keyboard_modifiers") do
  include_recipe "casecommons_workstation::logout_marker"
  mapping = ['<dict><key>HIDKeyboardModifierMappingDst</key><integer>2</integer><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer></dict>']
  ["1133-49221-0","1452-541-0","1452-544-0","1452-569-0"].each do |device|
    plist ".GlobalPreferences" do
      current_host true
      key "com.apple.keyboard.modifiermapping.#{device}"
      value mapping
    end
  end
  execute "notify user of logout" do
    command "true"
    notifies :run, "execute[touch-logout-required-marker]", :immediately
  end
end
