include_recipe "pivotal_workstation::github_ssh_keys"

script "add github to knownhosts" do
  interpreter "bash"
  user WS_USER
  cwd "#{WS_HOME}/.ssh"
  code <<-EOH
    touch known_hosts
    (cat known_hosts | grep github.com) || \
    echo "github.com,207.97.227.239 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==" >> known_hosts
  EOH
end

if ENV["GITHUB_PASSWORD"]
  github_name="#{WS_USER}@#{node[:fqdn]}"
  curl_options = "--retry 3 --retry-delay 5 --retry-max-time 30 --connect-timeout 5 --max-time 30"
  execute "upload ssh key to github if it does not already exist there" do
    not_if <<-SH
      curl #{curl_options} \
           --data-urlencode \"login=#{node[:github][:api][:login]}\" \
           --data-urlencode \"token=#{node[:github][:api][:token]}\" \
           #{node[:github][:api][:keys_url]} | grep "`cat #{WS_HOME}/.ssh/id_github_#{node["github_project"]}.pub` | cut -f 2 -d ' '`"
    SH
    command <<-SH
    curl -X POST --verbose #{curl_options} -u '#{node[:github][:api][:login]}:#{ENV["GITHUB_PASSWORD"]}' \
         --data "{ \\"key\\": \\"`cat #{WS_HOME}/.ssh/id_github_#{node["github_project"]}.pub`\\", \\"title\\": \\"#{github_name}\\" }" \
         #{node[:github][:api][:add_url]}
    SH
  end
  user WS_USER
else
  puts "No GITHUB_PASSWORD provided, cannot run"
end

