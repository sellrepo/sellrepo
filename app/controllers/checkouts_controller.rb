class CheckoutsController < ApplicationController
  authenticate_user! with: :sign_up, return_to: false
  before_action :set_product

  def show
    case SellRepo.payment_processor
    when :stripe
      stripe_checkout
    when :lemon_squeezy
      lemon_squeezy_checkout
    else
      redirect_to @product, alert: "Payments are not enabled."
    end
  end

  private

  def set_product
    @product = Product.find_by!(slug: params[:product_id])
  end

  def stripe_checkout
    args = {
      mode: @product.interval? ? :subscription : :payment,
      line_items: @product.stripe_price_id,
      success_url: return_url,
      cancel_url: product_url(@product, host: request.host)
    }

    metadata = {
      user_id: current_user.id,
      product_id: @product.id
    }

    if @product.interval?
      args[:subscription_data] = { metadata: metadata }
    else
      args[:payment_intent_data] = { metadata: metadata }
    end

    payment_processor = current_user.set_payment_processor(:stripe)
    checkout_session = payment_processor.checkout(**args)
    redirect_to checkout_session.url, allow_other_host: true
  end

  def lemon_squeezy_checkout
    payment_processor = current_user.set_payment_processor(:lemon_squeezy)
    checkout_session = payment_processor.checkout(
      variant_id: @product.lemon_squeezy_variant_id,
      product_options: {
        redirect_url: return_url
      },
      checkout_data: {
        email: current_user.email,
        name: current_user.name
      }
    )
    redirect_to checkout_session.url, allow_other_host: true
  end

  def return_url
    product_checkout_return_url(@product, host: request.host)
  end
end
