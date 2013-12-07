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

  template "/etc/httpd/conf/httpd.conf" do
    source "httpd.conf.erb"
    owner "root"
    group "root"
    mode 0644
  end

  template "/etc/httpd/vhost.d/001-default.conf" do
    source "001-default.conf.erb"
    owner "root"
    group "root"
    mode 0644
  end

when "ubuntu","debian"
  template "/etc/apache2/apache2.conf" do
    source "apache2.conf.erb"
    owner "root"
    group "root"
    mode 0644
  end

  template "/etc/apache2/sites-available/001-default.conf" do
    source "001-default-ubuntu.conf.erb"
    owner "root"
    group "root"
    mode 0644
  end

  execute "a2ensite 001-default.conf" 
end


case node[:platform]
when "redhat","centos"
service "httpd" do
  action :restart
end
when "ubuntu","debian"
service "apache2" do
  action :restart
end
end




