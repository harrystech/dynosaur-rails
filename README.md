### Authentication

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


