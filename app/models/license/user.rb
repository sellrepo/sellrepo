class License::User < ApplicationRecord
  belongs_to :license, counter_cache: true

  validates :github_username, presence: true, uniqueness: { scope: :license_id }

  def github_url
    "https://github.com/#{github_username}"
  end

  def github_avatar_url
    github_url + ".png"
  end

  after_create :add_to_github

  def add_to_github
    GithubClient.new.add_collaborator(repository: license.product.github_repo, username: github_username)
  end

  before_destroy :remove_from_github

  def remove_from_github
    GithubClient.new.remove_collaborator(repository: license.product.github_repo, username: github_username)
  end
end
