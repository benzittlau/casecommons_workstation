execute "upgrade-homebrew-to-0.8.1" do
  not_if "test `brew --version` = '0.8.1'"
  command "brew update"
end
