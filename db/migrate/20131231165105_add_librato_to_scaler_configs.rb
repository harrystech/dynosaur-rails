class AddLibratoToScalerConfigs < ActiveRecord::Migration
  def change
     add_column :scaler_configs, :librato_email, :string
     add_column :scaler_configs, :librato_api_key, :string
  end
end
