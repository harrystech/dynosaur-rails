class UpdateScalerConfig < ActiveRecord::Migration
  def up
    remove_column :scaler_configs, :min_web_dynos
    remove_column :scaler_configs, :max_web_dynos
  end

  def down
    add_column :scaler_configs, :min_web_dynos, :integer
    add_column :scaler_configs, :max_web_dynos, :integer
  end
end
