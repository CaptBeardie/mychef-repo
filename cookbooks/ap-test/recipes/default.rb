#
# Cookbook Name:: ap-test
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "httpd"

service "httpd" do
  action [ :start, :enable ]
end

template "/etc/httpd/conf/httpd.conf.NEW" do
  source "httpd.conf.NEW"
  owner "apache"
  group "apache"
  mode 0644
  #notifies :restart, "service[httpd]"
end

cookbook_dir "/etc/httpd/vhost.d" do
  source "vhost.d-conf"
  mode 0755
  notifies :graceful, "service[httpd]"
end

