module SellRepo
  class << self
    def self.configured?
      github_token? && payments? && (Rails.env.production? ? smtp? : true)
    end

    def github_token
      ENV["GITHUB_TOKEN"] || Rails.application.credentials.github.dig(:token)
    end

    def github_token?
      !!github_token
    end

    def smtp_host
      ENV.fetch("SMTP_HOST", Rails.application.credentials.smtp.dig(:host))
    end

    def smtp_domain
      ENV.fetch("SMTP_DOMAIN", Rails.application.credentials.smtp.dig(:domain))
    end

    def smtp_username
      ENV.fetch("SMTP_USERNAME", Rails.application.credentials.smtp.dig(:username))
    end

    def smtp_password
      ENV.fetch("SMTP_PASSWORD", Rails.application.credentials.smtp.dig(:password))
    end

    def smtp?
      !!smtp_host
    end
  end
end
