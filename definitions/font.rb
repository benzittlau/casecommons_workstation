define :font do
  directory "#{WS_LIBRARY}/Fonts" do
    action :create
    owner node[:myself]
  end
  
  remote_file "#{WS_LIBRARY}/Fonts/#{params[:name]}" do
    not_if "test -e '#{WS_LIBRARY}/Fonts/#{params[:name]}'"
    source params[:source]
    mode "0644"
    owner node[:myself]
  end
end

