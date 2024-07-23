class Product < ApplicationRecord
  has_rich_text :description
  has_one_attached :featured_image
  has_many_attached :media

  validates :name, presence: true, uniqueness: true
  validates :github_repo, presence: true

  before_validation do
    self.slug ||= name.parameterize
  end

  def to_param
    slug
  end
end
