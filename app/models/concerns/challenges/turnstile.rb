module Challenges::Turnstile
  extend ActiveSupport::Concern

  included do
    attribute :challenge_token
    validates :challenge_token, turnstile: true, on: :create, if: -> { TurnstileClient.enabled? }
  end
end
