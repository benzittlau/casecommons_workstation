template "/etc/sysctl.conf" do
  source "sysctl.conf.erb"
end

execute "set kernal SHMMAX" do
  command "sysctl -w kern.sysv.shmmax=6442450944"
end

execute "set kernal SHMALL" do
  command "sysctl -w kern.sysv.shmall=393216"
end
