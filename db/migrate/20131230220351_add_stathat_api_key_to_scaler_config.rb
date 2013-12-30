class AddStathatApiKeyToScalerConfig < ActiveRecord::Migration
  def change
     add_column :scaler_configs, :stathat_api_key, :string
     remove_column :scaler_configs, :stats
  end
end
