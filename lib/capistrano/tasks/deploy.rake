namespace 'deploy' do
  desc "Run both Chef and Capistrano recipes"
  task 'full' => ['chef:run_app_recipe', 'deploy']

  desc "Run both Chef and Capistrano recipes, but don't run bundle and librarian-install"
  task 'full_quick' do
    set :chef_quick, true
    invoke 'deploy:full'
  end
end
