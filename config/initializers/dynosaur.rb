
puts "Running dynosaur initializers"

require "dynosaur"
require 'pry'

config = ScalerConfig.last(:order => "id asc", :limit => 1)

if !config.nil?
  Dynosaur.initialize(config.get_hash)
  Dynosaur.start_in_thread
end
