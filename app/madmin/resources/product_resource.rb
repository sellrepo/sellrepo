class ProductResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :hidden
  attribute :name
  attribute :slug, index: false, label: "URL Slug"
  attribute :featured_image, index: false, description: "Recommended 1280x720 or higher with 16x9 aspect ratio"
  attribute :github_repo, placeholder: "https://github.com/username/repository"

  attribute :stripe_price_id, placeholder: "price_12345"
  attribute :lemon_squeezy_variant_id, placeholder: "12345"
  attribute :amount_in_cents, :currency, form: false, minor_units: true, label: "Amount"
  attribute :interval, form: false
  attribute :interval_count, form: false
  attribute :allowed_users, index: false, description: "The number of GitHub users allowed to access the repository per license."

  attribute :description, index: false

  attribute :created_at, form: false
  attribute :updated_at, form: false

  # Associations
  attribute :licenses, form: false

  scope :one_time
  scope :recurring

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
