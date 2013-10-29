require 'spec_helper'

describe ScalerConfig do
  it "should load and save config with plugins" do
    config = get_dynosaur_config(2)

    h = config.get_hash
    puts h.inspect

    h["scaler"]["min_web_dynos"].should eql 3

    h["plugins"][0]["name"].should eql "random_0"
    h["plugins"][0]["seed"].should eql "1234"

  end


end

def get_dynosaur_config(num_plugins)
  api_key = SecureRandom.uuid
  app_name = SecureRandom.uuid[0..12]
  config = ScalerConfig.new
  config.min_web_dynos = 3
  config.max_web_dynos = 27
  config.heroku_app_name = app_name
  config.heroku_api_key = api_key
  config.dry_run = true
  config.interval = 5
  config.blackout = 10
  config.save!

  plugins = []
  num_plugins.times { |i|
    plugin = config.plugin_configs.new
    plugin.name = "random_#{i}"
    plugin.plugin_type = "RandomPlugin"
    plugin.save!
    plugin.set_item("seed", "1234")
    plugins << plugin
  }
  return config
end
