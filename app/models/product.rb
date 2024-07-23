class Product < ApplicationRecord
  has_rich_text :description
  has_one_attached :featured_image

  validates :name, presence: true, uniqueness: true
  validates :github_repo, presence: true

  before_validation do
    self.slug ||= name.parameterize
  end

  before_validation if: :stripe_price_id_changed? do
    self.amount_in_cents = ::Stripe::Price.retrieve(stripe_price_id).unit_amount
  end

  def to_param
    slug
  end
end
