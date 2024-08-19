class ApplicationController < ActionController::Base
  include Pagy::Backend

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def app_config
    @app_config ||= Config.first_or_create do |config|
      config.name = ENV["APP_NAME"]
      config.support_url = ENV["SUPPORT_URL"]
    end
  end

  def app_name
    ENV.fetch("APP_NAME", app_config.name) || "Your Store"
  end

  def support_url
    ENV.fetch("SUPPORT_URL", app_config.support_url)
  end
  helper_method :app_config, :app_name, :support_url
end
