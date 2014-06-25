require 'pp'
include_recipe 'myproject::environment'
::Kernel.pp cfg.to_h
