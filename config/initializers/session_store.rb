# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_js_logger_session',
  :secret      => 'f63df04b4eddf5021030bd41b29152485b7d943c5cdd5b2fbeab52e6cd8b4a2f928632affe32853050e69f8ebbe1082d130435a455b622b0335e12b1e41c0d6a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
