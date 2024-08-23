class CheckoutsController < ApplicationController
  authenticate_user! with: :sign_up, return_to: false
  before_action :set_product

  def show
    if ::Stripe.api_key.present?
      stripe_checkout
    elsif
      lemon_squeezy_checkout
    else
      redirect_to @product, alert: "Payments are not enabled"
    end
  end

  private

  def set_product
    @product = Product.find_by!(slug: params[:product_id])
  end

  def stripe_checkout_args
    args = {
      mode: @product.interval? ? :subscription : :payment,
      line_items: @product.stripe_price_id,
      success_url: product_checkout_return_url
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
    args = {
      variant_id: @product.lemon_squeezy_id,
      product_options: {
        return_url: product_checkout_return_url
      }
    }

    payment_processor = current_user.set_payment_processor(:lemon_squeezy)
    checkout_session = payment_processor.checkout()
    redirect_to checkout.url, allow_other_host: true
  end
end
