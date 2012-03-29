execute "add-custom-audit-variable-to-pgconf" do
  not_if %{grep "custom_variable_classes = 'audit'" /usr/local/var/postgres/postgresql.conf}
  command "echo \"custom_variable_classes = 'audit'\" >> /usr/local/var/postgres/postgresql.conf"
end

script "restart-postgres-if-needed" do
  not_if %{psql -d postgres -c 'set audit.user_id=-1'}
  interpreter "bash"
  code <<-SH
    launchctl unload -w ~/Library/LaunchAgents/*postgres*.plist
    sleep 5
    launchctl load -w ~/Library/LaunchAgents/*postgres*
  SH
  user WS_USER
end
