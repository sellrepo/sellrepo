class User < ApplicationRecord
  include ReviseAuth::Model

  has_person_name
  pay_customer default_payment_processor: SellRepo.payment_processor

  has_many :licenses, -> { active }, dependent: :destroy

  scope :admins, -> { where(admin: true) }
  scope :customers, -> { where(admin: false) }
end
