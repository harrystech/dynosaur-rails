class ConfigController < ApplicationController
  def index
    @config = ScalerConfig.last(:order => "id asc", :limit => 1)
    if @config.nil?
        @config = ScalerConfig.new
    end
  end

  def submit
    puts params.inspect

    config_params = params["config"]

    @config = nil
    if config_params["id"].empty?
      @config = ScalerConfig.new
    else
      @config = ScalerConfig.find(config_params["id"])
      puts "Updating existing config: #{@config.id}"
    end

    @config.heroku_app_name = config_params["heroku_app_name"]
    @config.heroku_api_key = config_params["heroku_api_key"]
    @config.min_web_dynos = config_params["min_web_dynos"]
    @config.max_web_dynos = config_params["max_web_dynos"]
    @config.interval = config_params["interval"]
    @config.blackout = config_params["blackout"]
    @config.dry_run = config_params["dry_run"]
    @config.stats = config_params["stats"]


    begin
      @config.save!
    rescue Exception => e
      puts "Failed validation #{e.inspect}"
      @errors = e.record.errors
    end

    puts "Doing dynosaur reconfig"
    Dynosaur.set_config(@config.get_hash)
    redirect_to(:action => index)

  end

  def show_plugin

    @plugin_config_templates = {}

    @plugin_types = []
    ScalerPlugin.subclasses.each { |klass|
      @plugin_types << klass.name
      @plugin_config_templates[klass.name] = klass.get_config_template
    }

    name = params[:name]


    @config = ScalerConfig.last(:order => "id asc", :limit => 1)

    if @config.nil?
      raise "No scaler config yet!"
    end

    if !name.nil?
      @plugin_config = @config.plugin_configs.where(:name => name).first

      if @plugin_config.nil?
        raise "Couldn't find plugin_config"
      end
    else
      @plugin_config = @config.plugin_configs.new
    end


  end

  def post_plugin
    config_params = params["config"]

    @config = nil
    if config_params.has_key? "id"
      @config = ScalerConfig.find(config_params["id"])
      puts "Updating plugin for config ##{@config.id}"
    else
      raise "Unknown config id ##{config_params.id}"
    end

    plugin_config = params["plugin_config"]
    name = plugin_config["name"]

    @plugin_config = @config.plugin_configs.where(:name => name).first
    if @plugin_config.nil?
      puts "New plugin config '#{name}'"
      @plugin_config = @config.plugin_configs.new(:name => name)
    else
      puts "Updating plugin config '#{name}'"
    end

    @plugin_config.plugin_type = plugin_config["plugin_type"]
    @plugin_config.interval = plugin_config["interval"]
    @plugin_config.save!

    plugin_config.each { |item_name, item_value|
      unless ["plugin_type", "interval"].include?(item_name)
        puts "Saving config: #{item_name}"
        @plugin_config.set_item(item_name, item_value)
      end
    }

    Dynosaur.set_config(@config.get_hash)


    redirect_to(:action => :show_plugin, :name => name)
  end

end
