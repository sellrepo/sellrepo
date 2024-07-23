class ProductResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :name
  attribute :github_repo
  attribute :amount_in_cents
  attribute :stripe_price_id
  attribute :created_at, form: false
  attribute :updated_at, form: false
  attribute :description, index: false
  attribute :featured_image, index: false
  attribute :media, index: false

  # Associations

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
