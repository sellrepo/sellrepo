ReviseAuth.configure do |config|
  # Customize the params for registration and update profile.
  config.sign_up_params += [ :name, :challenge_token ]
  config.update_params += [ :name ]
end
