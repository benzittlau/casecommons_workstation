define :dock do
    require 'plist'
    dock_plist = "#{WS_LIBRARY}/Preferences/com.apple.dock.plist"
    `plutil -convert xml1 #{dock_plist}`
    dock_xml = Plist::parse_xml(dock_plist)

    dock_xml["autohide"] = params[:autohide] unless  params[:autohide].nil?

    File.open(dock_plist, "w") do |plist_handle|
      plist_handle.puts Plist::Emit.dump(dock_xml)
    end
end
