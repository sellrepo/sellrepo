class ConfigResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :app_name, index: true
  attribute :support_url do |config|
    config.placeholder = "mailto:support@example.org"
  end
  attribute :github_token do |config|
    config.index = false
    config.description = "Use a <a href=\"https://github.com/settings/personal-access-tokens/new\" target=\"_blank\">GitHub Personal Access token</a> with Read & Write access to repository Administration (to add collaborators)".html_safe
  end
  attribute :logo, index: true
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
