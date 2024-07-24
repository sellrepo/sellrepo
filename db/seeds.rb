# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
email = ENV.fetch("ADMIN_EMAIL", "admin@example.org")

User.where(email: email).first_or_create! do |user|
  password = SecureRandom.alphanumeric(16)
  user.password = password
  user.password_confirmation = password
  user.admin = true

  puts "Your login credentials are: #{email} / #{password}"
end
