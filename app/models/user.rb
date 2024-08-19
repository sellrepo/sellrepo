class User < ApplicationRecord
  include ReviseAuth::Model

  pay_customer default_payment_processor: :stripe

  has_many :licenses, ->{ active }, dependent: :destroy

  scope :admins, -> { where(admin: true) }
  scope :customers, -> { where(admin: false) }
end
