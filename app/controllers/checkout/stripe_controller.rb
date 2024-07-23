class Checkout::StripeController < ApplicationController
  before_action :authenticate_user!

  def show
    charge = Pay.sync(params)
    redirect_to charge.license
  end
end
