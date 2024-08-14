# SellRepo

Your personal storefront for selling GitHub repos.

## Usage

We recommend

## Running Locally

This application is preconfigured for [DevContainers](https://guides.rubyonrails.org/getting_started_with_devcontainer.html) or you can use a local Ruby install to run it. We like using [Mise](https://mise.jdx.dev/) to install Ruby.

```ruby
# Install dependencies
bundle

# Run Rails
bin/rails server
```

### Create an Admin user

Admin users are able to manage the store and access the admin area for configuration and customer support.

Run `bin/rails db:seed` to create an admin user. You can override the admin email address when running this command:

```ruby
ADMIN_EMAIL=you@example.org bin/rails db:seed
```

A random password will be generated and printed out. You can change your password after logging in.

## Deployment

You can deploy SellRepo with Kamal, Heroku, Render, Fly, Hatchbox.io, or your preferred method.

### Sending email in production

By default, SellRepo is configured to use SMTP for sending emails. To configure your transactional email service, set the following environment variables with the details from your email provider.

```bash
SMTP_HOST=smtp.example.com
SMTP_DOMAIN=yourdomain.com
SMTP_USERNAME=username
SMTP_PASSWORD=password
```

You can change this in `config/environments/production.rb` to use another email service if you prefer.

### Creating an admin user in production

Once deployed, you'll need to create an admin user in your production database. See your hosting provider's documentation about running one-off commands.

```ruby
ADMIN_EMAIL=you@example.org bin/rails db:seed
```

A random password will be generated and printed out. You can change your password after logging in.
