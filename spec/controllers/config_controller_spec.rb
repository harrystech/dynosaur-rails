require 'spec_helper'

describe ConfigController do

  describe "GET 'submit'" do
    it "returns http success" do
      get 'submit'
      response.should be_success
    end
  end

end
