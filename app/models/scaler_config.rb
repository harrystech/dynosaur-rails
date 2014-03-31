class ScalerConfig < ActiveRecord::Base
  has_many :plugin_configs
  attr_accessible :dry_run, :heroku_api_key, :heroku_app_name, :interval, :max_web_dynos, :min_web_dynos, :librato_email, :librato_api_key

  validates :heroku_app_name, :heroku_api_key, :interval, :max_web_dynos, :min_web_dynos, :presence => true

  def get_hash
    h = {
      "scaler" => {
        "min_web_dynos" => self.min_web_dynos,
        "max_web_dynos" => self.max_web_dynos,
        "heroku_app_name" => self.heroku_app_name,
        "heroku_api_key" => self.heroku_api_key,
        "dry_run" => self.dry_run,
        "librato_email" => self.librato_email,
        "librato_api_key" => self.librato_api_key,
        "interval" => self.interval,
      }
    }
    plugins = []
    if self.plugin_configs
      self.plugin_configs.each { |plugin|
        plugins << plugin.get_hash
      }
    end
    h["plugins"] = plugins
    return h
  end
end
