puts "#{node.name} #{node.hostname} #{node.ipaddress} #{node.environment} #{node.roles}"
# Run recipes for current node (server) by default
include_recipe "myproject::#{node.name}"
