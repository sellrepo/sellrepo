module LogoHelper
  def logo(class: "h-6")
    if SellRepo.config.logo.attached?
      image_tag(app_config.logo, class: "h-6", alt: store_name)
    else
      SellRepo.store_name
    end
  end
end
