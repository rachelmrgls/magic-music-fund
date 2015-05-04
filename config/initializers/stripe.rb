Rails.configuration.stripe = {
  :publishable_key => "pk_test_b3qBzfxOU5EdIEEca8anwoQv",
  :secret_key      => "sk_test_6fMKKvnEUkQIMYsCSj2WlqHb"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]