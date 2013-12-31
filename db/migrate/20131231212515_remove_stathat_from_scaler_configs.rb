class RemoveStathatFromScalerConfigs < ActiveRecord::Migration
  def change
    remove_column :scaler_configs, :stathat_api_key
  end

end
