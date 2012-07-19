include_recipe "casecommons_workstation::fonts"

unless File.exists?("/Applications/iTerm.app")

  remote_file "/tmp/iterm2.zip" do
    source "http://iterm2.googlecode.com/files/iTerm2-1_0_0_20111020.zip"
    mode "0644"
  end

  execute "unzip iterm" do
    command "unzip /tmp/iterm2.zip iTerm.app/* -d /Applications/"
    user WS_USER
  end
end

template "/tmp/com.googlecode.iterm2.plist.xml" do
  # To get this, convert the binary plist to XML
  # e.g. plutil -convert xml1 ~/Library/Preferences/com.googlecode.iterm2.plist
  source "com.googlecode.iterm2.xml.erb"
  owner WS_USER
end

execute "import-iterm-plist" do
  command "plutil -convert binary1 /tmp/com.googlecode.iterm2.plist.xml -o #{WS_LIBRARY}/Preferences/com.googlecode.iterm2.plist"
  user WS_USER
end
