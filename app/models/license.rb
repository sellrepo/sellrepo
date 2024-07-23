class License < ApplicationRecord
  belongs_to :product
  belongs_to :pay_charge, class_name: "Pay::Charge", inverse_of: :license
  has_many :users

  def name
    super || product.name
  end

  def allowed_users
    1
  end

  def available?
    users_count < allowed_users
  end
end
