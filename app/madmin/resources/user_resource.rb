class UserResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :email
  attribute :confirmed_at
  attribute :unconfirmed_email
  attribute :admin
  attribute :created_at, form: false
  attribute :updated_at, form: false
  attribute :password, index: false, show: false
  attribute :password_confirmation, index: false, show: false

  # Associations
  attribute :pay_customers
  attribute :charges
  attribute :subscriptions
  attribute :payment_processor
  attribute :licenses

  scope :admins
  scope :customers

  # Uncomment this to customize the display name of records in the admin area.
  # def self.display_name(record)
  #   record.name
  # end

  # Uncomment this to customize the default sort column and direction.
  # def self.default_sort_column
  #   "created_at"
  # end
  #
  # def self.default_sort_direction
  #   "desc"
  # end
end
