
puts "Running dynosaur initializers"

require "dynosaur"


begin
  config = ScalerConfig.last(:order => "id asc", :limit => 1)

  Dynosaur.initialize(config.get_hash)
  if !config.nil?
    Dynosaur.start_in_thread
  end
rescue Exception => e
  puts e
  puts "Oh noes! Couldn't initialize Dynosaur (is the db ready yet?)"
  puts "WARNING: NOT RUNNING DYNOSAUR!"
end
