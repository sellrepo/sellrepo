class Checkout::ReturnsController < ApplicationController
  before_action :authenticate_user!

  def show
    charge_or_subscription = Pay.sync(params)
    redirect_to charge_or_subscription&.license || licenses_path
  end
end
