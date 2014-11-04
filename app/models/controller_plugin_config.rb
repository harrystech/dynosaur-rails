class ControllerPluginConfig < ActiveRecord::Base
  belongs_to :scaler_config

  attr_accessible :name, :min_resource, :max_resource, :plugin_type

  has_many :input_plugin_configs

  def get_hash
    h = {
      "name" => self.name,
      "type" => self.plugin_type,
      "min_resource" => self.min_resource,
      "max_resource" => self.max_resource,
      "dry_run" => self.dry_run,
    }
    input_plugins = []
    if self.input_plugin_configs
      self.input_plugin_configs.each do |plugin|
        input_plugins << plugin.get_hash
      end
    end
    h['input_plugins'] = input_plugins
    return h
  end
end
