class BillingsController < ApplicationController
  before_action :authenticate_user!

  def show
    case SellRepo.payment_processor
    when :stripe
      stripe
    when :lemon_squeezy
      lemon_squeezy
    else
      redirect_to root_path, alert: "Payments are not enabled."
    end
  end

  def stripe
    portal = current_user.payment_processor.billing_portal
    redirect_to portal.url, allow_other_host: true
  end

  def lemon_squeezy
    if (url = current_user.payment_processor.portal_url)
      redirect_to current_user.payment_processor.portal_url, allow_other_host: true
    else
      redirect_to root_path, alert: "Billing is only accessible when you have an active subscription."
    end
  end
end
