class Product < ApplicationRecord
  has_many :licenses, dependent: :destroy

  has_rich_text :description
  has_one_attached :featured_image

  scope :one_time, -> { where(interval_count: nil) }
  scope :recurring, -> { where.not(interval_count: nil) }

  validates :name, presence: true, uniqueness: true
  validates :github_repo, presence: true
  validates :stripe_price_id, presence: true, format: { with: /\Aprice_.+\z/ }
  validate :github_repository_exists

  normalizes :github_repo, with: -> { _1.split("github.com/").last }

  before_validation do
    self.slug ||= name.parameterize
  end

  before_validation if: :stripe_price_id_changed? do
    price = ::Stripe::Price.retrieve(stripe_price_id)
    assign_attributes(
      amount_in_cents: price.unit_amount,
      interval: price.recurring&.interval,
      interval_count: price.recurring&.interval_count,
    )
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
