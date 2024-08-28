class User < ApplicationRecord
  include ReviseAuth::Model

<<<<<<< HEAD
  has_person_name
  pay_customer default_payment_processor: SellRepo.payment_processor
=======
  pay_customer
>>>>>>> 1850cbcd713708cc07d9216835b029641d2499aa

  has_many :licenses, -> { active }, dependent: :destroy

  scope :admins, -> { where(admin: true) }
  scope :customers, -> { where(admin: false) }
end
