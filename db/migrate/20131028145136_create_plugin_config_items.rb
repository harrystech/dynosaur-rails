class CreatePluginConfigItems < ActiveRecord::Migration
  def change
    create_table :plugin_config_items do |t|
      t.integer :plugin_config_id
      t.string :name
      t.string :value

      t.timestamps
    end
  end
end
