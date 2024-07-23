module LogoHelper
  def logo(class: "h-6")
    if app_config.logo.attached?
      image_tag(app_config.logo, class: "h-6", alt: app_name)
    else
      app_name
    end
  end
end
