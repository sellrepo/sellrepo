module ChargeExtensions
  extend ActiveSupport::Concern

  included do
    has_one :license, inverse_of: :pay_charge
    after_create_commit :create_license
  end

  def create_license
    user.licenses.where(product: product, pay_charge: self).first_or_create!
  end

  def user
    @user ||= User.find_by(metadata["user_id"])
  end

  def product
    @product ||= Product.find(metadata["product_id"])
  end
end

Rails.configuration.to_prepare do
  Pay::Charge.include ChargeExtensions
end
