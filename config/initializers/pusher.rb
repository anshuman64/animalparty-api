require 'pusher'

Pusher.app_id = ENV["PUSHER_APP_ID"]
Pusher.key = ENV["ANIMALPARTY_PUSHER_KEY"]
Pusher.secret = ENV["ANIMALPARTY_PUSHER_SECRET"]
Pusher.cluster = 'us2'
Pusher.logger = Rails.logger
Pusher.encrypted = true
