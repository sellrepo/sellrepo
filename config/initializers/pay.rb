module SubscriptionExtensions
  extend ActiveSupport::Concern

  included do
    has_one :license, inverse_of: :pay_subscription
    after_commit :create_license, if: -> { product && status == "active" }
    after_update_commit :update_license, if: -> { product }
  end

  def create_license
    user.licenses.where(
      product: product,
      pay_subscription: self
    ).first_or_create!(
      state: :active,
      name: "#{product.name} License",
      allowed_users: product.allowed_users
    )

    UserMailer.with(license: license).purchase_notification_email.deliver_later if SellRepo.purchase_notifications?
  end

  def user
    return if metadata&.dig("user_id").blank?
    @user ||= User.find_by(id: metadata["user_id"])
  end

  def product
    return if metadata&.dig("product_id").blank?
    @product ||= Product.find_by(id: metadata["product_id"])
  end

  # Remove license users if subscription goes into an inactive state
  def update_license
    if %w[ paused unpaid canceled incomplete_expired ].include? status
      license.archive
    end
  end
end

module ChargeExtensions
  extend ActiveSupport::Concern

  included do
    has_one :license, inverse_of: :pay_charge
    after_create_commit :create_license, if: -> { product }
  end

  def create_license
    user.licenses.where(
      product: product,
      pay_charge: self
    ).first_or_create!(
      state: :active,
      name: "#{product.name} License",
      allowed_users: product.allowed_users
    )

    UserMailer.with(license: license).purchase_notification_email.deliver_later if SellRepo.purchase_notifications?
  end

  def user
    return if metadata&.dig("user_id").blank?
    @user ||= User.find_by(id: metadata["user_id"])
  end

  def product
    return if metadata&.dig("product_id").blank?
    @product ||= Product.find_by(id: metadata["product_id"])
  end

  def pdf_product_name
    product&.name || super
  end
end

Rails.configuration.to_prepare do
  Pay::Charge.include ChargeExtensions
  Pay::Subscription.include SubscriptionExtensions

  Pay.setup do |config|
    # For use in the receipt/refund/renewal mailers
    config.business_name = SellRepo.company_name
    config.application_name = SellRepo.store_name
  end

  # Use Inter font for full UTF-8 support in PDFs
  # https://github.com/rsms/inter
  Receipts.default_font = {
    bold: Rails.root.join("app/assets/fonts/Inter-Bold.ttf"),
    normal: Rails.root.join("app/assets/fonts/Inter-Regular.ttf")
  }
end
