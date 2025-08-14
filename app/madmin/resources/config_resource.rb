class ConfigResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :store_name, index: true, label: "Your store's name", placeholder: "My Store"
  attribute :company_name, index: true, label: "Your company's name", placeholder: "Example, LLC"
  attribute :description, description: "A short description for SEO. Typically 70-155 characters."
  attribute :support_url do |config|
    config.placeholder = "mailto:support@example.org"
  end
  attribute :logo_url, placeholder: "https://s3.amazonaws.com/..."
  attribute :logo

  attribute :opengraph_image_url
  attribute :opengraph_image

  attribute :purchase_notifications, label: "Enable purchase notification emails", description: "Send email notifications to admins when purchases are made"

  attribute :created_at, form: false
  attribute :updated_at, form: false

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
