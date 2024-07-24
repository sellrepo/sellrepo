class Product < ApplicationRecord
  has_rich_text :description
  has_one_attached :featured_image

  validates :name, presence: true, uniqueness: true
  validates :github_repo, presence: true
  validates :stripe_price_id, presence: true, format: { with: /\Aprice_/ }
  validate :github_repository_exists

  normalizes :github_repo, with: -> { _1.split("github.com/").last }

  before_validation do
    self.slug ||= name.parameterize
  end

  before_validation if: :stripe_price_id_changed? do
    price = ::Stripe::Price.retrieve(stripe_price_id)
    self.amount_in_cents = price.unit_amount
    errors.add :stripe_price_id, "must be a one-time price" if price.type != "one_time"
  rescue ::Stripe::StripeError => e
    errors.add :stripe_price_id, e.message
  end

  def to_param
    slug
  end

  def github_repository_exists
    GithubClient.new.repository(github_repo)
  rescue
    errors.add :github_repo, "Unable to find repository. Check that your GitHub token has access to this repository and there are no typos."
  end
end
