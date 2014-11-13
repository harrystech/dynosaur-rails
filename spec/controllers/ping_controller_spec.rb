require 'spec_helper'

describe PingController do
  before(:all) do
    config = get_dynosaur_config(1)
  end
  describe "GET 'ping'" do
    it "returns http success" do
      get 'ping'
      response.should be_success
    end

    context 'all good' do
      it "returns http success" do
        get 'ping'
        response.should be_success
      end
    end

    context 'with stale plugins' do
      before do
        Dynosaur.stub(:get_status).and_return(
          {
            "stopped"=>false,
            "controller_status"=> [
              {
                "time"=>5.minutes.ago,
                "name"=>"dynos",
                "current"=>3,
                "current_estimate"=>3,
                "last_changed"=> 5.minutes.ago,
                "results"=> {
                  "ga"=> {
                    "estimate"=>3,
                    "value"=>400,
                    "unit"=>"active users",
                    "last_retrieved"=> 5.minutes.ago,
                    "health"=>"STALE"
                  }
                }
              }
            ]
          }
        )
      end
      it "returns a 500" do
        get 'ping'
        response.should be_error
      end
    end
  end

end
