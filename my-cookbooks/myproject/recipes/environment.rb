server, env, app = node.environment.split '_'
load_app_settings app, server, env

directory '/var/www/apps' do
  owner cfg.deploy_user
  group cfg.deploy_user
end
