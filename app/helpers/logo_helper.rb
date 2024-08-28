module LogoHelper
  def logo(class: "h-6")
    if SellRepo.config.logo.attached?
      image_tag(SellRepo.config.logo, class: "h-6", alt: SellRepo.store_name)
    else
      SellRepo.store_name
    end
  end
end