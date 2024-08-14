class Pay::ChargeResource < Madmin::Resource
  attribute :id, index: true, form: false
  attribute :customer, index: true
  attribute :license
  attribute :processor_id
  attribute :currency, index: true
  attribute :amount, :currency do |config|
    config.index = true
    config.minor_units = true
  end
  attribute :amount_refunded
  attribute :payment_method_type
  attribute :metadata, index: false
  attribute :created_at, form: false
  attribute :updated_at, form: false, index: false
  attribute :stripe_receipt_url, :string, index: false
  attribute :brand, index: false
  attribute :last4, index: false
  attribute :exp_month, index: false
  attribute :exp_year, index: false
  attribute :email, index: false
  attribute :username, index: false
  attribute :bank, index: false
  attribute :amount_captured, index: false
  attribute :period_start, index: false
  attribute :period_end, index: false
  attribute :line_items, index: false
  attribute :subtotal, index: false
  attribute :tax, index: false
  attribute :discounts, index: false
  attribute :total_discount_amounts, index: false
  attribute :total_tax_amounts, index: false
  attribute :refunds, index: false

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
