class CreateScalerConfigs < ActiveRecord::Migration
  def change
    create_table :scaler_configs do |t|
      t.integer :min_web_dynos
      t.integer :max_web_dynos
      t.string :heroku_app_name
      t.string :heroku_api_key
      t.boolean :dry_run
      t.integer :interval
      t.integer :blackout

      t.timestamps
    end
  end
end
