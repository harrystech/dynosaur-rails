class HomeController < ApplicationController
  def index
    @status = Dynosaur.get_status
    @name = Dynosaur.heroku_app_name[0..12]
  end
end
