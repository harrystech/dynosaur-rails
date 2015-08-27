require 'spec_helper'

describe ConfigController, type: :controller do
  before(:all) do
    config = get_dynosaur_config(1)
  end
  before do
    @config = get_dynosaur_config(2)
    basic_auth_login
  end

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      response.should be_success
    end
  end

  describe "POST 'submit'" do
    it "returns http success" do
      pending
      fail
    end
  end

end
