#
# Cookbook Name:: SFTP_chrootbroken
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Add our own sshd_configs and restart to take affect
case node[:platform]
when "redhat","centos"
template "/etc/ssh/sshd_config" do
  source "centos_sshd_config.erb"
  mode 600
  owner "root"
  group "root"
end

service "sshd" do
  action :restart
end

when "ubuntu","debian"
template "/etc/ssh/sshd_config" do
  source "ubu_sshd_config.erb"
  mode 600
  owner "root"
  group "root"
end

service "ssh" do
  action :restart
end
end


# Add our group only if it doesn't already exist

execute "groupadd sftp-users" do
  not_if "grep sftp-users /etc/group"
end

# If user already exists, reset it
case node[:platform]
when "redhat","centos"
execute "usermod -s /bin/false -g sftp-users bobdole && echo 'bobsaget' | passwd --stdin bobdole && usermod -L bobdole" do
  only_if "id bobdole"
end

when "ubuntu","debian"
execute "usermod -s /bin/false -g sftp-users -p `mkpasswd bobsaget` bobdole && usermod -L bobdole" do
  only_if "id bobdole"
end
end

# Add user account if it doesn't exist 

case node[:platform]
when "redhat","centos"
execute "useradd -s /bin/false -g sftp-users bobdole && echo 'bobsaget' | passwd --stdin bobdole && usermod -L bobdole" do
  not_if "id bobdole"
end

when "ubuntu","debian"
execute "useradd -s /bin/false -g sftp-users -m -p `mkpasswd bobsaget` bobdole && usermod -L bobdole" do
  not_if "id bobdole"
end
end

