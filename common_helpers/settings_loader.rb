require 'configatron'

module SettingsDSL
  def delayed_attr(&block)
    Configatron::Delayed.new &block
  end

  def dyn_attr(&block)
    Configatron::Dynamic.new &block
  end

  module ObjectPatch
    def cfg
      configatron
    end
  end
end
extend SettingsDSL
include SettingsDSL::ObjectPatch

module SettingsLoader
  def load_settings(name, raise_if_not_exists: false)
    if File.exist? "#{::DEPLOYMENT_ROOT}/settings/#{name}.rb"
      require "settings/#{name}"
    else
      raise "Could not find setting #{name}" if raise_if_not_exists
    end
  end

  def load_app_settings(app_name, app_server, app_env)
    cfg.app_name = app_name
    cfg.app_server = app_server
    cfg.app_env = app_env
    [
      'common',
      "servers/#{app_server}",
      "environments/#{app_env}",
      "applications/#{app_name}",
      "#{app_server}_#{app_env}",
      "#{app_server}_#{app_name}",
      "#{app_name}_#{app_env}",
      "#{app_server}_#{app_env}_#{app_name}",
    ].each{|s| load_settings s }
    cfg.lock!
  end

  def settings_to_h(conf = cfg, h = {})
    conf.each do |k, v|
      h[k] = Configatron::Store === v ? settings_to_h(v) : v
    end
    h
  end
end
