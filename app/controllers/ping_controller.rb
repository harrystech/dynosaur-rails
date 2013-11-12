class PingController < ApplicationController
  def ping
    ip = request.headers.fetch("X-Forwarded-For", request.ip)
    puts "Ping from #{ip}"

    @status = Dynosaur.get_status

    bad_plugins = []
    @status["results"].each { |name, result|
      if result["health"] != "OK"
        bad_plugins << name
      end
    }
    puts @status.inspect

    if bad_plugins.empty?
      render :text => "OK\n"
    else
      render :text => "BAD: #{bad_plugins}"
    end
  end

  def basic_auth
  end

  def ip_whitelist
  end
end
