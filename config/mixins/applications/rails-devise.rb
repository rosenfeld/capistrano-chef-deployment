mixin 'puma'

set :rails_env, 'production'
set :migration_role, :application
set :assets_roles, :application
set :puma_bind, "tcp://localhost:#{cfg.rails_devise.listen_port}"
before 'deploy:updated', 'rails_devise:upload_config'

# The following is a hack since we don't own the application.
# Usually you'd simply add puma to your Gemfile and commit it...
before 'bundler:install', 'add_puma_to_gemfile' do
  on roles(:application) do
    execute %Q{echo "gem 'puma'" >> #{release_path}/Gemfile}
    within(release_path){execute :bundle}
  end
end
