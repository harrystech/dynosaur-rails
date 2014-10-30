class RenamePluginConfigs < ActiveRecord::Migration
  def up
    rename_table :plugin_configs, :input_plugin_configs
  end

  def down
    rename_table :input_plugin_configs, :plugin_configs
  end
end
