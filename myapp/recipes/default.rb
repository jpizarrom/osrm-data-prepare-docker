#
# Cookbook Name:: myapp
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

osrm_map_download 'chile' do
 action :download
end

osrm_map 'chile' do
  profile         'bicycle'
  action :create
end

# osrm_routed 'chile' do
#   profile         'bicycle'
#   listen '0.0.0.0'
#   port         5000
# end