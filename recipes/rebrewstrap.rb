cookbook_file "/usr/local/bin/rebrewstrap" do
  source "rebrewstrap.sh"
  mode "0755"
end
