class TurnstileValidator < ActiveModel::EachValidator
  DEFAULT_MESSAGE = "Challenge failed."

  def validate_each(record, attribute, value)
    unless TurnstileClient.verify(value).success
      record.errors.add :base, options.fetch(:message) { DEFAULT_MESSAGE }
    end
  end
end
