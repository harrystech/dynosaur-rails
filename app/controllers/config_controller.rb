class ConfigController < ApplicationController
  def index
    @config = ScalerConfig.last(:order => "id asc", :limit => 1)
    if @config.nil?
        puts "Showing config form for new config"
        @config = ScalerConfig.new
    else
      puts "Showing config form for scaler_config = #{@config.id}"
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
    @config.interval = config_params["interval"]
    @config.dry_run = config_params["dry_run"]
    @config.librato_api_key = config_params["librato_api_key"]
    @config.librato_email = config_params["librato_email"]


    begin
      @config.save!
    rescue ActiveRecord::RecordInvalid => e
      puts "Failed validation #{e.inspect}"
      @errors = e.record.errors
    end

    puts "Doing dynosaur reconfig"
    Dynosaur.set_config(@config.get_hash)
    redirect_to(:action => index)

  end

  def show_controller_plugin

    @plugin_config_templates = {}

    @controller_plugin_types = []
    Dynosaur::Controllers::AbstractControllerPlugin.subclasses.each { |klass|
      @controller_plugin_types << klass.name
    }

    name = params[:name]

    @config = ScalerConfig.last(:order => "id asc", :limit => 1)

    if @config.nil?
      raise "No scaler config yet!"
    end

    if !name.nil?
      @controller_plugin_config = @config.controller_plugin_configs.where(:name => name).first
      @controller_plugin_type = @controller_plugin_config.plugin_type

      if @controller_plugin_config.nil?
        raise "Couldn't find plugin_config"
      end
    else
      @controller_plugin_type = @controller_plugin_types[0]
      @controller_plugin_config = @config.controller_plugin_configs.new
    end


  end

  def post_controller_plugin
    config_params = params["config"]

    @config = nil
    if config_params.has_key? "id"
      @config = ScalerConfig.find(config_params["id"])
      puts "Updating plugin for config ##{@config.id}"
    else
      raise "Unknown config id ##{config_params.id}"
    end

    plugin_config = params["controller_plugin_config"]
    name = plugin_config["name"]

    @controller_plugin_config = @config.controller_plugin_configs.where(:name => name).first
    if @controller_plugin_config.nil?
      puts "New plugin config '#{name}'"
      @controller_plugin_config = @config.controller_plugin_configs.new(:name => name)
    else
      puts "Updating plugin config '#{name}'"
    end

    @controller_plugin_config.plugin_type = plugin_config["plugin_type"]
    @controller_plugin_config.min_resource = plugin_config["min_resource"]
    @controller_plugin_config.max_resource = plugin_config["max_resource"]
    @controller_plugin_config.dry_run = plugin_config["dry_run"]
    @controller_plugin_config.save!

    Dynosaur.set_config(@config.get_hash)


    redirect_to(:action => :show_controller_plugin, :name => name)
  end

  def show_input_plugin

    @plugin_config_templates = {}
    @input_plugin_types = []

    Dynosaur::Inputs::AbstractInputPlugin.subclasses.each { |klass|
      @input_plugin_types << klass.name
      @plugin_config_templates[klass.name] = klass.get_config_template
    }

    name = params[:name]

    @controller_config =  ControllerPluginConfig.find(params['controller_plugin_id'])

    if @controller_config.nil?
      raise "No scaler config yet!"
    end

    if !name.nil?
      @input_plugin_config = @controller_config.input_plugin_configs.where(:name => name).first
      @input_plugin_type = @input_plugin_config.plugin_type

      if @input_plugin_config.nil?
        raise "Couldn't find plugin_config"
      end
    else
      @input_plugin_type = @input_plugin_types[0]
      @input_plugin_config = @controller_config.input_plugin_configs.new
    end

  end

  def post_input_plugin

    plugin_config = params["input_plugin_config"]
    @controller_config =  ControllerPluginConfig.find(params['controller_plugin_id'])
    name = plugin_config[:name]

    @input_plugin_config = @controller_config.input_plugin_configs.where(name: name).first
    if @input_plugin_config.nil?
      puts "New input plugin config #{name}"
      @input_plugin_config = @controller_config.input_plugin_configs.new(name: name)
    else
      puts "Updating input plugin config #{name}"
    end

    @input_plugin_config.plugin_type = plugin_config['plugin_type']
    @input_plugin_config.interval = plugin_config['interval']
    @input_plugin_config.hysteresis_period = plugin_config['hysteresis_period']
    @input_plugin_config.save!

    plugin_config.each { |item_name, item_value|
      if !["plugin_type", "interval", "hysteresis_period"].include?(item_name)
        puts "Saving config: #{item_name}"
        @input_plugin_config.set_item(item_name, item_value)
      end
    }

    @scaler_config = @input_plugin_config.controller_plugin_config.scaler_config
    Dynosaur.set_config(@scaler_config.get_hash)

    redirect_to(:action => :show_input_plugin, :name => name)
  end

end
