class Product < ApplicationRecord
  has_rich_text :description
  has_one_attached :featured_image

  validates :name, presence: true, uniqueness: true
  validates :github_repo, presence: true
  validate :github_repository_exists

  before_validation do
    self.slug ||= name.parameterize
  end

  before_validation if: :stripe_price_id_changed? do
    self.amount_in_cents = ::Stripe::Price.retrieve(stripe_price_id).unit_amount
  end

  def to_param
    slug
  end

  def github_repo_path
    github_repo.split("github.com/").last
  end

  def github_repository_exists
    GithubClient.new.repository(github_repo_path)
  rescue
    errors.add :github_repo, "Unable to find repository. Check that your GitHub token has access to this repository and there are no typos."
  end
end
