module Product::Github
  extend ActiveSupport::Concern

  included do
    validates :github_repo, presence: true
    validate :github_repository_exists
    normalizes :github_repo, with: -> { _1.split("github.com/").last }
  end

  def github_repository_exists
    GithubClient.new.repository(github_repo)
  rescue
    errors.add :github_repo, "Unable to find repository. Check that your GitHub token has access to this repository and there are no typos."
  end
end
