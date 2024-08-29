namespace :sellrepo do
  desc "Generates an admin user"
  task admin: :environment do
    puts "What email should we use for the admin user?"
    email = gets.chomp

    if (user = User.find_by(email: email))
      user.update!(admin: true)
      puts "#{email} is now an admin."
    else
      password = SecureRandom.alphanumeric(16)
      User.create!(
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
  end
end
