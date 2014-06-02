set :puma_role, :application
# Work-around for bad defaults for Puma (or at least it should take care of creating the dirs)
before 'puma:start', 'create_puma_required_default_dirs'
before 'puma:restart', 'create_puma_required_default_dirs'
before 'puma:phased-restart', 'create_puma_required_default_dirs'
task 'create_puma_required_default_dirs' do
  on roles(:application) do
    within(shared_path) do
      execute :mkdir, '-p', 'tmp/pids', 'tmp/sockets', 'log'
    end
  end
end

