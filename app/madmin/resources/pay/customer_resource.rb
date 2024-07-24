class Pay::CustomerResource < Madmin::Resource
  attribute :id, form: false
  attribute :owner
  attribute :charges
  attribute :payment_methods
  attribute :default_payment_method
  attribute :processor, index: false
  attribute :processor_id
  attribute :deleted_at, index: false
  attribute :created_at, form: false
  attribute :updated_at, form: false, index: false
  attribute :payment_method_token, index: false
  attribute :currency, index: false


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
