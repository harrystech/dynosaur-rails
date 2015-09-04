require 'spec_helper'

describe HomeController do
  before(:all) do
    config = get_dynosaur_config(1)
    Dynosaur.initialize(config.get_hash)
  end

  before do
    basic_auth_login
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end
