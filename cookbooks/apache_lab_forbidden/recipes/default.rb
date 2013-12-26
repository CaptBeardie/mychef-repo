#
# Cookbook Name:: apache_lab_forbidden
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# First clear all existing vhosts
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

# Clear existing docroot if it exists
execute "rm -rf /var/www/vhosts/example.com" do
  only_if "test -d /var/www/vhosts/example.com"
end

# Add the custom CentOS apache config and vhost files
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

# Or add the custom Ubuntu apache config and vhost files

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


# Add the vhost docroot
directory "/var/www/vhosts/example.com" do
  mode 0700
  owner "root"
  group "root"
end

# Add our index and .htaccess files
template "/var/www/vhosts/example.com/Index.html" do
  source "Index.html"
  mode 644
  owner "root"
  group "root"
end

template "/var/www/vhosts/example.com/.htaccess" do
  source "bad.htaccess"
  mode 644
  owner "root"
  group "root"
end



# Finially, restart the service

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




