class TurnstileClient < ApplicationClient
  BASE_URI = "https://challenges.cloudflare.com/turnstile/v0"

  def self.enabled?
    site_key && secret_key
  end

  def self.site_key
    ENV["TURNSTILE_SITE_KEY"] || Rails.application.credentials.dig(:turnstile, :site_key)
  end

  def self.secret_key
    ENV["TURNSTILE_SECRET_KEY"] || Rails.application.credentials.dig(:turnstile, :secret_key)
  end

  def self.verify(...)
    new.verify(...)
  end

  def verify(token)
    post "/siteverify", body: { secret: self.class.secret_key, response: token, remoteip: Current.ip_address }
  end
end
