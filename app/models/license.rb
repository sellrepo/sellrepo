class License < ApplicationRecord
  belongs_to :user, class_name: "::User"
  belongs_to :product
  belongs_to :pay_charge, class_name: "Pay::Charge", inverse_of: :license, optional: true
  belongs_to :pay_subscription, class_name: "Pay::Subscription", inverse_of: :license, optional: true
  has_many :users, dependent: :destroy

  scope :active, -> { where(state: :active) }
  scope :inactive, -> { where(state: :inactive) }

  validates :state, inclusion: { in: %w[active inactive] }

  def can_add_users?
    users_count < allowed_users
  end
end
