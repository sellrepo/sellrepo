class GithubClient < ApplicationClient
  BASE_URI = "https://api.github.com"

  def add_collaborator(repostiory:, username:)
    put "/repos/#{repository}/collaborators/#{username}", body: { permission: :triage }
  end

  def remove_collaborator(repository:, username:)
    delete "/repos/#{repository}/collaborators/#{username}"
  end

  def default_headers
  end

  def content_type
    "application/vnd.github+json"
  end
end
