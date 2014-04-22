class AddHysteresisToPluginConfig < ActiveRecord::Migration
  def change
    add_column :plugin_configs, :hysteresis_period, :integer
  end
end
