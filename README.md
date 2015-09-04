# Dynosaur-Rails

This is a web admin interface and simple deploy mechanism for
[Dynosaur](http://github.com/harrystech/dynosaur), a pluggable Heroku
autoscaler. It is a rails app designed to be run on Heroku with only environment
variables for configuration. This rails app runs the dynosaur autoscaler in a
background thread, displays status, and allows the user to configure the
autoscaler.

## DEPRECATION WARNING!

**We (Harry's) have decided to deprecate dynosaur-rails and turn dynosaur into
a headless console app configured with YAML file. We just found it hard to
maintain the web app, had let the
front page reporting/status feature stay undeveloped for a year or so, and
generally feel it adds little value.**

**Dynosaur itself is a critical piece of our infrastructure and we intend to
maintain it for the foreseeable future. There is nothing (as far as we know)
stopping you from continuing to use Dynosaur Rails with the corresponding
Dynosaur v0.5.1.**

Having said that, here's the documentation for dynosaur-rails:

## Getting Started

    Fork the repo and pull it down locally
    bundle install
    rake db:migrate
    rename the config/application.yml.example file to config/application.yml

This app only requires that the SECRET_TOKEN environment variable is set (although we suggest you set up
some authentication too, see below). To generate a secret token:

    rake secret

Then set the environment variable in the application.yml file:

    SECRET_TOKEN: <YOUR SECRET>


## Authentication

The default security is HTTP basic auth, with username 'admin' and password
'password'. To set new credentials, set the following environment variables

    DYNOSAUR_USERNAME: myuser
    DYNOSAUR_PASSWORD: mypass

It would be better to bcrypt the password variable. We have included a script to
generate a bcrypted password string. Run:

    bundle exec script/gen-password PASSWORD
    DYNOSAUR_PASSWORD: <ENCRYPTED_PASSWORD>

We also offer an IP address whitelist feature. Set the following environment
variable as a comma-separated list of IP addresses:

    curl -s http://ifconfig.me
    DYNOSAUR_IP_WHITELIST: '10.0.1.2,192.168.1.34'

## Deployment

Initialize the Heroku app:

    heroku create
    git remote -v
    heroku addons:add heroku-postgresql
    heroku addons:add papertrail


Set Heroku environment variables:

    heroku config:set RAKE_ENV=production
    heroku config:set RAILS_ENV=production
    heroku config:set SECRET_TOKEN=<YOUR SECRET>
    heroku config:set DYNOSAUR_IP_WHITELIST=$(curl -s http://ifconfig.me)

Deploy to Heroku:

    git commit your files
    git push heroku master
    heroku run rake db:migrate

## Usage

Once up and running, you can configure your dynosaur instance (see the
[Dynosaur Docs](http://github.com/harrystech/dynosaur) for explanation of the
different parameters.

After configuring the main Dynosaur parameters, you must restart the app before
configuring plugins.

Add a plugin (e.g. Google Analytics and set all the params required).

Restart the rails app and you should see that your autoscaler is running. It
will show you the results of the individual plugins, which you can compare to
e.g. the Google Analytics website.

## Limitations

1. You must restart the app after adding plugins (`heroku restart`)
2. You have to remove plugins manually from the database and restart the rails
   app if you want to delete them.
3. Validation of plugin config is not very forgiving and you can lose your
   progress.

[![TravisCI](https://travis-ci.org/harrystech/dynosaur-rails.png)](https://travis-ci.org/harrystech/dynosaur-rails)
