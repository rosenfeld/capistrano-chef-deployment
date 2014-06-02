include_recipe 'nginx'

template "#{node.nginx.dir}/sites-available/#{cfg.app_name}_#{cfg.app_env}" do
  source "nginx/myproject.conf.erb"
  mode "0644"
end

nginx_site "#{cfg.app_name}_#{cfg.app_env}"

cookbook_file '/etc/nginx/conf.d/log-format.conf' do
  source 'nginx/log-format.conf'
end

# workaround over some unreliable nginx init scripts on Ubuntu
execute "nginx -t"
execute 'service nginx start'
execute 'service nginx reload'
