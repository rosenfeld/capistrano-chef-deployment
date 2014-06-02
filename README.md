# Sample deployment scaffold integrating Chef and Capistrano

This project integrates Capistrano and Chef recipes. Capistrano is used to deploy applications
as a regular account (deploy by default) while `chef-solo` is run as root.

The recipes illustrate how to deploy multiple applications and environments to your servers.

The bootstrap and prepare scripts will ensure the deployment account is created and that rbenv
is properly set up for this account. Chef is installed using `rbenv` but is run usin `rbenv sudo`.

Simply clone or fork and start working on your recipes.

## Setting up a development environment with Vagrant

**Important security note**: before you use this scaffold on your real projects,
make sure you replace `deploy-key` and `deploy-key.pub`.

    vagrant up
    bundle
    skip_rbenv=1 bundle exec cap chef chef:bootstrap server=vagrant
    skip_rbenv=1 bundle exec cap chef chef:prepare server=vagrant

## Deploying the sample application provided

    # will run both chef and Capistrano:
    bundle exec cap app deploy:full spec=vagrant_development_rails-devise
    # will run chef-solo only for the given environment
    bundle exec cap app chef:run_app_recipe spec=vagrant_production_rails-devise
    # will run Capistrano only for the given environment
    bundle exec cap app deploy spec=vagrant_production_rails-devise
    # To simply print the settings for some environment if you want to check them:
    bundle exec cap app config:print spec=vagrant_production_rails-devise
