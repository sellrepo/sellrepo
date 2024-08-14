class BillingsController < ApplicationController
  before_action :authenticate_user!

  def show
    portal = current_user.payment_processor.billing_portal
    redirect_to portal.url, allow_other_host: true
  end
end
