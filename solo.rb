Chef::Config.ssl_verify_mode = :verify_peer

# See available configs here: http://docs.opscode.com/config_rb_solo.html
dir = Dir.pwd # we can't use __dir__ as this file is not required, but loaded instead :(
cookbook_path ["#{dir}/cookbooks", "#{dir}/my-cookbooks"]
environment_path "#{dir}/environments"
node_path "#{dir}/nodes"
role_path "#{dir}/roles"
data_bag_path "#{dir}/data_bags"

# if you want to be able to run your chef recipes as a regular user (for simple tests):
file_cache_path "#{dir}/chef-cache"
file_backup_path "#{dir}/chef-backup"
checksum_path "#{dir}/chef-checksum"
sandbox_path "#{dir}/chef-sandbox"
