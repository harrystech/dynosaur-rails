class ControllerPluginConfig < ActiveRecord::Base
  belongs_to :scaler_config

  attr_accessible :name, :min_resource, :max_resource, :plugin_type

  has_many :input_plugin_configs

  def get_hash
    return {
      "name" => self.name,
      "type" => self.plugin_type,
      "min_resource" => self.min_resource,
      "max_resource" => self.max_resource,
    }
  end
end
