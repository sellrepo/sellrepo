module ProductsHelper
  def featured_image(product, classes: "w-full aspect-video rounded-md my-0")
    if product&.featured_image&.attached?
      image_tag(product.featured_image, class: classes)
    else
      tag.div class: class_names("placeholder-image", classes)
    end
  end

  def pricing(product)
    amount = number_to_currency(product.amount_in_cents / 100.0)
    if product.interval?
      interval = product.interval_count == 1 ? product.interval : pluralize(product.interval_count, product.interval)
      amount += " / #{interval}"
    end
    amount
  end
end
