class CheckoutsController < ApplicationController
  authenticate_user! with: :sign_up, return_to: false
  before_action :set_product

  def show
    checkout_session = current_user.payment_processor.checkout(**checkout_args)
    redirect_to checkout_session.url, allow_other_host: true
  end

  private

  def set_product
    @product = Product.find_by!(slug: params[:product_id])
  end

  def checkout_args
    args = {
      mode: @product.interval? ? :subscription : :payment,
      line_items: @product.stripe_price_id,
      success_url: product_checkout_stripe_url(@product)
    }

    if @product.interval?
      args[:subscription_data] = { metadata: metadata }
    else
      args[:payment_intent_data] = { metadata: metadata }
    end

    args
  end

  def metadata
    {
      user_id: current_user.id,
      product_id: @product.id
    }
  end
end
