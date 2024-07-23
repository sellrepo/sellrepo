class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product

  def show
    checkout_session = current_user.payment_processor.checkout(
      mode: "payment",
      line_items: @product.stripe_price_id,
      payment_intent_data: {
        metadata: metadata
      },
      success_url: product_checkout_stripe_url(@product),
    )
    redirect_to checkout_session.url, allow_other_host: true
  end

  private

  def set_product
    @product = Product.find_by!(slug: params[:product_id])
  end

  def metadata
    {
        user_id: current_user.id,
        product_id: @product.id
    }
  end
end
