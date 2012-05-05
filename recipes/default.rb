#
# Cookbook Name:: virtualbox
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

case node['platform']
when "debian", "ubuntu"
  execute "apt-get update" do
    action :nothing
  end

  comps = ['contrib']
  comps << 'non-free' unless ['precise', 'oneiric', 'natty'].include?(node['lsb']['codename'])

  apt_repository "virtualbox" do
    uri "http://download.virtualbox.org/virtualbox/debian"
    distribution node['lsb']['codename']
    components comps
    key "http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc"
    action :add
    notifies :run, "execute[apt-get update]", :immediately
  end

  package "virtualbox-4.1" do
    action :install
  end

  package "dkms" do
    action :install
  end
end
