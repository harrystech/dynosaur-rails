class AddControllerPluginConfigs < ActiveRecord::Migration
  def up
    create_table :controller_plugin_configs do |t|
      t.integer :scaler_config_id
      t.string :name
      t.string :plugin_type
      t.text :value

      t.timestamps
    end
  end

  def down
    drop_table :controller_plugin_configs
  end
end
