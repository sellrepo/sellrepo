namespace :sellrepo do
  desc "Generates an admin user"
  task admin: :environment do
    email = ARGV[1]

    if email.blank?
      puts <<~MESSAGE
        You must pass an email address to the command.

            bin/rails sellrepo:admin email@example.org
      MESSAGE
      exit 1
    end

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
  end
end
