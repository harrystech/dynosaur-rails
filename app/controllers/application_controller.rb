require 'bcrypt'
require 'pry'

class ApplicationController < ActionController::Base
  DEFAULT_USERNAME = "admin"
  DEFAULT_PASSWORD = "password"
  DEFAULT_IP_WHITELIST = "127.0.0.1"

  before_filter :ip_whitelist
  before_filter :basic_auth
  protect_from_forgery

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      expected_username = ENV.fetch("DYNOSAUR_USERNAME", DEFAULT_USERNAME)
      expected_password = ENV.fetch("DYNOSAUR_PASSWORD", DEFAULT_PASSWORD)
      if username != expected_username
        return false
      end
      bcyrpt_password = BCrypt::Password.new(expected_password)
      if expected_password == password || bcyrpt_password == password
        @passed_auth=true
        return true
      end
      puts "ERROR: Failed basic auth"
      request_http_basic_authentication
      return false
    end
  end

  def ip_whitelist
    allowed_ips = ENV.fetch("DYNOSAUR_IP_WHITELIST", DEFAULT_IP_WHITELIST).split(",")
    ip = request.headers.fetch("X-Forwarded-For", request.ip)
    if !allowed_ips.include?(ip)
      puts "ERROR: Failed IP check for #{ip}"
      render :file => "public/401.html", :status => :unauthorized, layout: false
    end
  end
end
