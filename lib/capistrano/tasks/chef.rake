namespace 'chef' do
  task :run_script, :roles, :script_name, :params, :env do |t, args|
    script_name = args[:script_name]
    env = (args[:env] || {}).map{|k, v| "#{k}='#{v}'"}.join ' '

    on args[:roles] do
      execute "rm -f /tmp/#{script_name}.sh"
      upload! "scripts/#{script_name}.sh", '/tmp/'
      execute "#{env} /tmp/#{script_name}.sh #{args[:params]}"
      execute "rm /tmp/#{script_name}.sh"
    end
  end

  desc 'Ensure a deploy account exists and can run sudo'
  task :bootstrap do
    on (roles = fetch(:bootstrap_roles)) do
      upload! 'deploy-key', '/tmp/'
      upload! 'deploy-key.pub', '/tmp/'
      invoke 'chef:run_script', roles, 'bootstrap-server', cfg.deploy_user
      execute 'rm -f /tmp/deploy-key /tmp/deploy-key.pub'
    end
  end

  desc 'Install rbenv and set-up deployment-chef'
  task :prepare do
    params = "#{cfg.deployment_repo_url} #{cfg.deployment_repo_host}"
    env = {symlink: 1} if cfg.deployment_repo_symlink
    invoke 'chef:run_script', roles(:application), 'prepare-chef', params, env
  end

  desc 'Run Chef application recipes'
  task :run_app_recipe do
    set :chef_env, "#{cfg.app_server}_#{cfg.app_env}_#{cfg.app_name}"
    invoke 'chef:run'
  end

  desc 'Run Chef recipes'
  task run: 'config:print' do
    on roles(:application) do
      runlist = ENV['runlist'] || cfg.chef_runlist.to_a.join(',')
      quick = ENV['quick'] || fetch(:chef_quick) ? 'quick=1 ' : ''
      skip_pull = cfg.deployment_repo_symlink ? 'skip_pull=1' : ''
      opts = "#{quick} #{skip_pull}"
      env = fetch(:chef_env) || ''
      execute "cd ~/provisioning/deployment && #{opts} ./apply #{runlist} #{env}"
    end
  end

  desc 'Run Chef recipes skiping bundle and librarian-install'
  task :quick_run do
    set :chef_quick, true
    invoke 'chef:run'
  end
end
