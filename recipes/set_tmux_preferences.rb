template "#{WS_HOME}/.tmux.conf" do
  source "dot_tmux.conf.erb"
  owner WS_USER
end
