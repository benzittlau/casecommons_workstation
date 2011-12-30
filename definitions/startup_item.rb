define :startup_item, program: nil do
  execute "add startup item to preferences" do
    not_if  "defaults read loginwindow | grep #{params[:program]}"
    only_if "test -e #{params[:program]}"
    command <<-SH
    defaults write loginwindow AutoLaunchedApplicationDictionary -array-add \
    '<dict><key>Hide</key><false/><key>Path</key><string>#{params[:program]}</string></dict>'
    SH
  end
end
