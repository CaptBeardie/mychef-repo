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
  owner "root"
  group "root"
  mode 0644
  #notifies :restart, "service[httpd]"
end

directory "/etc/httpd/conf-NOTHERE" do
  mode 0755
  owner "root"
  group "root"
  #notifies :graceful, "service[httpd]"
end

# Testing a missing directory
template "/etc/httpd/conf-NOTHERE/httpd.conf.NEW" do
  source "httpd.conf.NEW"
  owner "root"
  group "root"
  mode 0644
end

