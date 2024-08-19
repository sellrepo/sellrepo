module AvatarHelper
  def gravatar_url_for(email, **options)
    hash = Digest::MD5.hexdigest(email&.downcase || "")
    options.reverse_merge!(default: :mp, rating: :pg, size: 48)
    "https://secure.gravatar.com/avatar/#{hash}.png?#{options.to_param}"
  end
end
