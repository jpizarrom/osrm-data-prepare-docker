#
# Cookbook Name:: myapp
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

osrm_map_download ENV['REGION'] do
 action :download
end

osrm_map ENV['REGION'] do
  profile         ENV['PROFILE']
  action :create
end

# osrm_routed 'chile' do
#   profile         'bicycle'
#   listen '0.0.0.0'
#   port         5000
# end