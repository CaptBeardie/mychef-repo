#
# Cookbook Name:: apache_lab_forbidden
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


case node[:platform]
when "redhat","centos"
  execute "rm -rf /etc/httpd/vhost.d/*" do
    only_if "test -d /etc/httpd/vhost.d/"
  end
end

when "ubuntu","debian"
  execute "rm -rf /etc/apache2/sites-enabled/*" do
    only_if "test -d /etc/apache2/sites-enabled/"
  end
end

case node[:platform]
when "redhat","centos"
  directory "/etc/httpd/vhost.d" do
    mode 0755
    owner "root"
    group "root"
  end
end


template "/etc/httpd/vhost.d/001-default.conf" do
  source "001-default.conf.erb"
  owner "apache"
  group "apache"
  mode 0644
end



service "httpd" do
  action :restart
end



