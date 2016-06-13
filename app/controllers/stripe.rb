# Store the environment variables on the Rails.configuration object
Rails.configuration.stripe = {
  publishable_key: ENV['pk_test_V7VKH7eZIxK6HsRrdiQyEFQf'],
  secret_key: ENV['sk_test_8gpe41SvFzHWyLHAF1bOHpwz']
}

# Set our app-stored secret key with Stripe
Stripe.api_key = Rails.configuration.stripe[:secret_key]
