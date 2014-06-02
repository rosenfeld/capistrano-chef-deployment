require 'pp'
include_recipe 'myproject::environment'
::Kernel.pp settings_to_h
