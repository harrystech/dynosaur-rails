class UpdateControllerPluginConfigs < ActiveRecord::Migration
  def up
    add_column :controller_plugin_configs, :min_resource, :string
    add_column :controller_plugin_configs, :max_resource, :string
    add_column :controller_plugin_configs, :dry_run, :boolean, default: false
  end

  def down
    remove_column :controller_plugin_configs, :min_resource
    remove_column :controller_plugin_configs, :max_resource
    remove_column :controller_plugin_configs, :dry_run
  end
end
