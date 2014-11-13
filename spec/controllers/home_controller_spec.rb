require 'spec_helper'

describe HomeController do
  before(:all) do
    config = get_dynosaur_config(1)
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
