# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.


if !ENV.has_key?('SECRET_TOKEN')
  print "\n***********************************************************"
  print "\nWARNING: You will need to add 'SECRET_TOKEN' to your bash environment"
  print "\n\techo \"export SECRET_TOKEN=\\\"$(rake secret)\\\"\" >> ~/.bash_profile\n"
  puts "\n*************************************************************\n"
end


DynosaurRails::Application.config.secret_token = ENV['SECRET_TOKEN']
