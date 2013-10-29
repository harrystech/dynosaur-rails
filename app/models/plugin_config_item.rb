class PluginConfigItem < ActiveRecord::Base
  belongs_to :plugin_config
  attr_accessible :name, :value
end
