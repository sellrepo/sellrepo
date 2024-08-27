class License::User < ApplicationRecord
  belongs_to :license, counter_cache: true

  validates :github_username, presence: true, uniqueness: { scope: :license_id }

  after_create :add_to_github
  before_destroy :remove_from_github

  def github_url
    "https://github.com/#{github_username}"
  end

  def github_avatar_url
    github_url + ".png"
  end

  def add_to_github
    GithubClient.new.add_collaborator(repository: license.product.github_repo, username: github_username)
  end

  # Don't remove if there are other License::User with the same github_username for this product
  def remove_from_github
    return if other_active_licenses?
    GithubClient.new.remove_collaborator(repository: license.product.github_repo, username: github_username)
  end

  def other_active_licenses?
    License::User.excluding(self).joins(:license).where(licenses: { state: :active, product_id: license.product_id }).any?
  end
end
