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

