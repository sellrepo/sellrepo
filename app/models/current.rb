class Current < ActiveSupport::CurrentAttributes
  attribute :config
  attribute :request_id, :user_agent, :ip_address
end
