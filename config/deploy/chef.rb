if ENV['spec']
  server, env, app = ENV['spec'].split('_')
else
  server = ENV['server']
  app = ENV['app']
  env = ENV['env']
end
unless server && !server.empty?
  abort "A server must be specified with server=server_name or using spec=server_env_app"
end
load_app_settings app, server, env
set :bootstrap_roles, bootstrap_roles = []
cfg.server.hosts.each do |host|
  server "#{cfg.deploy_user}@#{host}", roles: ['application']
  bootstrap_roles << Capistrano::Configuration::Server["root@#{host}"]
end
