class ProductResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :featured_image, index: false
  attribute :name
  attribute :slug, index: false
  attribute :description, index: false
  attribute :github_repo
  attribute :stripe_price_id
  attribute :amount_in_cents, form: :false
  attribute :allowed_users, index: false
  attribute :created_at, form: false
  attribute :updated_at, form: false

  # Associations

  # Uncomment this to customize the display name of records in the admin area.
  def self.display_name(record)
    record.name
  end

  # Uncomment this to customize the default sort column and direction.
  # def self.default_sort_column
  #   "created_at"
  # end
  #
  # def self.default_sort_direction
  #   "desc"
  # end
end
