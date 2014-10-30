require 'spec_helper'

describe ScalerConfig do
  it "should load and save config with plugins" do
    config = get_dynosaur_config(2)

    h = config.get_hash
    puts h.inspect


    h["controller_plugins"][0]["name"].should eql "random_0"

  end


end

