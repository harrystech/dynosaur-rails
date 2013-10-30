# Dynosaur-Rails

This is a web admin interface and simple deploy mechanism for 
[Dynosaur](http://github.com/harrystech/dynosaur"), a pluggable Heroku
autoscaler. It is a rails app designed to be run on Heroku with only environment
variables for configuration. This rails app runs the dynosaur autoscaler in a
background thread, displays status, and allows the user to configure the
autoscaler.

## Deployment

Add a heroku remote

	git add remote heroku

Deploy to heroku

    git push heroku

Set environment variables

	heroku ... TODO

## Config

This app requires only one environment variable (although we suggest you set up
some authentication too, see below).


    SECRET_TOKEN=<YOUR SECRET>

To generate a secret token, run

    rake secret

## Authentication

The default security is HTTP basic auth, with username 'admin' and password
'password'. To set new credentials, set the following environment variables

    DYNOSAUR_USERNAME=myuser
    DYNOSAUR_PASSWORD=mypass

It would be better to bcrypt the password variable. We have included a script to
generate a bcrypted password string:

    bundle exec script/gen-password PASSWORD
    # Note: use single quotes to avoid issues with '$' in the bcrypt string
    DYNOSAUR_PASSWORD='<ENCRYPTED_PASSWORD>'

We also offer an IP address whitelist feature. Set the following environment
variable as a comma-separated list of IP addresses:

    DYNOSAUR_IP_WHITELIST="10.0.1.2,192.168.1.34"

## Usage

Once up and running, you can configure your dynosaur instance (see the
[Dynosaur Docs](http://github.com/harrystech/dynosaur) for explanation of the
different parameters.

Add a plugin (e.g. Google Analytics and set all the params required).

Restart the rails app and you should see that your autoscaler is running. It
will show you the results of the individual plugins, which you can compare to
e.g. the Google Analytics website.

## Limitations

1. You may need to restart the app to add or remove plugins
1. You have to remove plugins manually from the database and restart the rails
   app.
1. Validation of plugin config is not very forgiving and you can lose your
   progress.

