module SellRepo
  class << self
    def configured?
      return true if ENV["SKIP_WELCOME"]
      github_token? && payments? && (Rails.env.production? ? smtp? : true)
    end

    def payment_processor
      if Pay::Stripe.private_key.present?
        :stripe
      elsif Pay::LemonSqueezy.api_key.present?
        :lemon_squeezy
      end
    end

    def admin?
      User.admins.any?
    end

    def store_name?
      config.store_name?
    end

    def store_name
      config.store_name || "My Store"
    end

    def company_name
      config.company_name || "Example, LLC"
    end

    def support_url
      config.support_url
    end

    def github_token
      ENV["GITHUB_TOKEN"] || Rails.application.credentials.github&.dig(:token)
    end

    def github_token?
      !!github_token
    end

    def payments?
      Pay::Stripe.enabled? && !!Pay::Stripe.private_key
    end

    def smtp_host
      ENV.fetch("SMTP_HOST", Rails.application.credentials.smtp&.dig(:host))
    end

    def smtp_domain
      ENV.fetch("SMTP_DOMAIN", Rails.application.credentials.smtp&.dig(:domain))
    end

    def smtp_username
      ENV.fetch("SMTP_USERNAME", Rails.application.credentials.smtp&.dig(:username))
    end

    def smtp_password
      ENV.fetch("SMTP_PASSWORD", Rails.application.credentials.smtp&.dig(:password))
    end

    def smtp?
      !!smtp_host
    end

    def config
      Current.config ||= Config.first_or_create
    end
  end
end
