require 'spec_helper'

describe PingController do

  describe "GET 'ping'" do
    it "returns http success" do
      get 'ping'
      response.should be_success
    end
  end

end
