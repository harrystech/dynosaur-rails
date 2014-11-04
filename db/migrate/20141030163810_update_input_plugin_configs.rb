class UpdateInputPluginConfigs < ActiveRecord::Migration
  def up
    add_column :input_plugin_configs, :controller_plugin_config_id, :integer
    remove_column :input_plugin_configs, :scaler_config_id
  end

  def down
    remove_column :input_plugin_configs, :controller_plugin_config_id
    add_column :input_plugin_configs, :scaler_config_id, :integer
  end
end
