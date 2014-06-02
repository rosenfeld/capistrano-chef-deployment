require 'set'

cfg.chef_runlist = Set.new
#cfg.chef_runlist << 'myproject::print_environment_settings'
cfg.deploy_user = 'deploy'
cfg.deployment_repo_url = 'git@github.com:rosenfeld/capistrano-chef-deployment.git'
cfg.deployment_repo_host = 'github.com'
cfg.deployment_repo_symlink = false
cfg.nginx.default = false

# Delayed attributes: they are set to the block values unless explicitly set to other value
cfg.database_name = delayed_attr{ "app1_#{cfg.app_env}" }
cfg.nginx.subdomain = delayed_attr{ cfg.app_env }

# Dynamic/calculated attributes: those are always evaluated by the block
# Those attributes are not meant to be overrideable
cfg.nginx.host = dyn_attr{ "#{cfg.nginx.subdomain}.mydomain.com" }
