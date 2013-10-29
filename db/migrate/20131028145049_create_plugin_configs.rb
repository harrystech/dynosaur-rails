class CreatePluginConfigs < ActiveRecord::Migration
  def change
    create_table :plugin_configs do |t|
      t.integer :scaler_config_id
      t.string :name
      t.string :plugin_type

      t.timestamps
    end
  end
end
