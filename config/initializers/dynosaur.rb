
puts "Running dynosaur initializers"

require "dynosaur"


begin
  config = ScalerConfig.last(:order => "id asc", :limit => 1)

  if !config.nil?
    Dynosaur.initialize(config.get_hash)
    Dynosaur.start_in_thread
  end
rescue Exception => e
  puts e
  puts "Oh noes! Couldn't initialize Dynosaur (is the db ready yet?)"
  puts "WARNING: NOT RUNNING DYNOSAUR!"
end
