module SubscriptionExtensions
  extend ActiveSupport::Concern

  included do
    has_one :license, inverse_of: :pay_subscription
    after_commit :create_license, if: -> { product && status == "active" }
    after_update_commit :update_license, if: -> { product }
  end

  def create_license
    user.licenses.where(
      state: :active,
      name: "#{product.name} License",
      product: product,
      pay_subscription: self,
      allowed_users: product.allowed_users
    ).first_or_create!
  end

  def user
    return if metadata&.dig("user_id").blank?
    @user ||= User.find_by(metadata["user_id"])
  end

  def product
    return if metadata&.dig("product_id").blank?
    @product ||= Product.find(metadata["product_id"])
  end

  # Remove license users if subscription goes into an inactive state
  def update_license
    if %w[ paused unpaid canceled incomplete_expired ].include? status
      license.update(state: :inactive)
      license.license_users.each(&:remove_from_github)
    end
  end
end

module ChargeExtensions
  extend ActiveSupport::Concern

  included do
    has_one :license, inverse_of: :pay_charge
    after_create_commit :create_license, if: -> { product }
    after_update_commit :update_license
  end

  def create_license
    user.licenses.where(
      state: :active,
      name: "#{product.name} License",
      product: product,
      pay_charge: self,
      allowed_users: product.allowed_users
    ).first_or_create!
  end

  def user
    return if metadata&.dig("user_id").blank?
    @user ||= User.find_by(metadata["user_id"])
  end

  def product
    return if metadata&.dig("product_id").blank?
    @product ||= Product.find(metadata["product_id"])
  end
end

Rails.configuration.to_prepare do
  Pay::Charge.include ChargeExtensions
  Pay::Subscription.include SubscriptionExtensions
end
