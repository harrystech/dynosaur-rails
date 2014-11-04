class ScalerConfig < ActiveRecord::Base
  has_many :controller_plugin_configs
  attr_accessible :dry_run, :heroku_api_key, :heroku_app_name, :interval, :librato_email, :librato_api_key

  validates :heroku_app_name, :heroku_api_key, :interval, :presence => true

  def get_hash
    h = {
      "scaler" => {
        "heroku_app_name" => self.heroku_app_name,
        "heroku_api_key" => self.heroku_api_key,
        "dry_run" => self.dry_run,
        "librato_email" => self.librato_email,
        "librato_api_key" => self.librato_api_key,
        "interval" => self.interval,
      }
    }
    controller_plugins = []
    if self.controller_plugin_configs
      self.controller_plugin_configs.each { |plugin|
        controller_plugins << plugin.get_hash
      }
    end
    h["controller_plugins"] = controller_plugins
    return h
  end
end
