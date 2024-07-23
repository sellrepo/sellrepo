class User < ApplicationRecord
  include ReviseAuth::Model

  pay_customer default_payment_processor: :stripe

  has_many :licenses, dependent: :destroy
end
