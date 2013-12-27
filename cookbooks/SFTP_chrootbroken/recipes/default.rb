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


# Add our group useraccount only if it doesn't already exist

execute "groupadd sftp-users" do
  not_if "grep sftp-users /etc/group"
end

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


# If user does exist..

execute "usermod -s /bin/false -g sftp-users -p `mkpasswd bobsaget` bobdole && usermod -L bobdole" do
  only_if "id bobdole"
end



