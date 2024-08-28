# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
email = ENV.fetch("EMAIL", "admin@example.org")


if (user = User.find_by(email: email))
  user.update(admin: true)
  puts "#{email} is now an admin."
else
  password = SecureRandom.alphanumeric(16)
  User.create(
    name: "Admin User",
    email: email,
    password: password,
    password_confirmation: password,
    admin: true
  )
  puts "Your login credentials are: #{email} / #{password}"
end

puts
puts "You can access the admin area by logging in and visiting /admin"
