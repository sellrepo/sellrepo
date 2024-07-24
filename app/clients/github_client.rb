class GithubClient < ApplicationClient
  BASE_URI = "https://api.github.com"

  def initialize
    super token: Config.first.github_token
  end

  def repository(repository)
    get "/repos/#{repository}"
  end

  def add_collaborator(repostiory:, username:)
    put "/repos/#{repository}/collaborators/#{username}", body: { permission: :triage }
  end

  def remove_collaborator(repository:, username:)
    delete "/repos/#{repository}/collaborators/#{username}"
  end

  def default_headers
    super.merge(
      "Accept" => "application/vnd.github+json",
      "X-GitHub-Api-Version" => "2022-11-28"
    )
  end
end
