require_relative 'chef'
unless [cfg.app_server, cfg.app_name, cfg.app_env].all?#{|v| !v.nil? && !v.empty? }
  abort "usage: bundle exec cap app server=ec2 app=app1 env=production (or spec=ec2_production_app1)"
end
puts "Running chef for #{cfg.app_name} - #{cfg.app_server} - #{cfg.app_env}"
mixin "applications/#{cfg.app_name}"
set :application, cfg.app_name
set :scm, cfg.app_scm
set :repo_url, cfg.app_repo_url
