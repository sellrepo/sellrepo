class License::User < ApplicationRecord
  belongs_to :license, counter_cache: true

  validates :github_username, presence: true, uniqueness: {scope: :license_id}

  def github_url
    "https://github.com/#{github_username}"
  end

  def github_avatar_url
    github_url + ".png"
  end
end
