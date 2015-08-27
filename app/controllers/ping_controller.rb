class PingController < ApplicationController
  OUTAGE_HORIZON = 300  # seconds
  def ping
    ip = request.headers.fetch("X-Forwarded-For", request.ip)
    now = Time.now
    puts "Ping from #{ip}"

    @status = Dynosaur.get_status
    bad_plugins = []
    controller_errors = []
    if !@status["controller_status"].nil?
      @status["controller_status"].each { |controller_status|
        controller_status['results'].each { |name, result|
          if result["health"] != "OK"
            bad_plugins << name
          end
        }
        last_error = controller_status["last_error"]
        if last_error.present? && now - last_error < OUTAGE_HORIZON
          controller_errors << "#{controller_status["name"]} error at #{last_error}"
        end
      }
      puts @status.inspect
    end

    status = 200

    text = ""
    if bad_plugins.present?
      text << "BAD: #{bad_plugins}\n"
      status = 500
    end
    if controller_errors.present?
        text << "BAD: #{controller_errors}\n"
        status = 500
    end
    if status == 200
      text = "OK\n"
    end
    render text: text, status: status
  end

  def basic_auth
  end

  def ip_whitelist
  end
end
