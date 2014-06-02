::DEPLOYMENT_ROOT = File.expand_path File.join __dir__, '..', '..', '..'
$: << DEPLOYMENT_ROOT
require "common_helpers/settings_loader"

class Chef
  class Recipe
    include SettingsLoader
  end
end

