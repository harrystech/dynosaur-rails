class UpdatePluginConfigItems < ActiveRecord::Migration
  def up
    remove_column :plugin_config_items, :plugin_config_id
    add_column :plugin_config_items, :input_plugin_config_id, :integer
  end

  def down
    remove_column :plugin_config_items, :input_plugin_config_id
    add_column :plugin_config_items, :plugin_config_id, :integer
  end
end
