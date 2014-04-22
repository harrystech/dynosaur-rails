class PluginConfig < ActiveRecord::Base
  belongs_to :scaler_config
  has_many :plugin_config_items
  attr_accessible :name, :plugin_type, :interval, :hysteresis_period

  validates :name, :plugin_type, :presence => true

  def set_item(name, value)
    # Look for it first
    existing = self.plugin_config_items.where(:name => name).first
    if !existing.nil?
      existing.value = value
      existing.save!
    else
      # Otherwise, create new
      item = self.plugin_config_items.new(:name => name, :value => value)
      item.save!
    end
  end

  def get_hash
    h = {
      "name" => self.name,
      "type" => self.plugin_type,
      "interval" => self.interval,
      "hysteresis_period" => self.hysteresis_period
    }
    self.plugin_config_items.each { |item|
      h[item.name] = item.value
    }
    return h
  end
end
