class Pay::CustomerResource < Madmin::Resource
  attribute :id, form: false
  attribute :owner, index: true, form: false
  attribute :charges, form: false
  attribute :processor, index: true, label:  "Payment Processor", form: false
  attribute :processor_id, label: "Processor ID", form: false
  attribute :deleted_at, index: false
  attribute :created_at, form: false
  attribute :updated_at, form: false, index: false

  member_action do
    link_to "View on Stripe", "https://dashboard.stripe.com/customers/#{@record.processor_id}", target: :_blank, class: "btn btn-secondary"
  end

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
