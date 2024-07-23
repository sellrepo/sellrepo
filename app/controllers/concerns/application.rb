module Application
  extend ActiveSupport::Concern

  included do
    helper_method :app_config, :app_name, :support_url
  end

  def app_config
    @app_config ||= Config.first_or_create(app_name: "Your Store")
  end

  def app_name
    ENV.fetch("APP_NAME", app_config.app_name)
  end

  def support_url
    ENV.fetch("SUPPORT_URL", app_config.support_url)
  end
end
