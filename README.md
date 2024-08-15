# SellRepo

Your personal storefront for selling access to GitHub repositories.

## Usage

To get started with SellRepo, we recommend creating a new repository and cloning the application into it. This will allow you to merge updates with git in the future.

```bash
git clone https://github.com/excid3/sellrepo
cd sellrepo
git remote rename origin upstream

# Add your repository as origin
git remote

# Push to your repository
git push -u origin main
```

Now you have a full copy of SellRepo in your own repository as the `origin` remote and the `sellrepo` remote for pulling updates.

To merge updates, you can fetch and merge from the sellrepo upstream.

```bash
git fetch sellrepo
git merge sellrepo/main
```

> [!NOTE]
> If you'd like to contribute a bug fix or improvement, you can fork the repository and send a Pull Request.

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

### Payments

To test payments locally, you'll need to provide the Stripe test environment secret key. This can be done in env vars or with Rails credentials.

```bash
STRIPE_PRIVATE_KEY=sk_test_1234 bin/rails server
```

Or with credentials, use environment credentials `bin/rails credentials:edit --environment=development`

```yaml
stripe:
  private_key: sk_test_1234
```

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

### Payments in production

First, you'll need your Stripe production secret key.

Second, you'll need to set up production webhooks to `https://yourdomain.com/webhooks/stripe`
After creating the production webhook, Stripe will provide a signing secret which you'll set as `STRIPE_SIGNING_SECRET`. This is used to ensure webhooks received came securely from Stripe.

Use environment variables or Rails credentials to set these for production.

```bash
STRIPE_PRIVATE_KEY=sk_12345
STRIPE_SIGNING_SECRET=whsec_12345
```

Or with credentials, use environment credentials `bin/rails credentials:edit --environment=production`

```yaml
stripe:
  private_key: sk_test_1234
  signing_secret: whsec_12345
```

### Creating an admin user in production

Once deployed, you'll need to create an admin user in your production database. See your hosting provider's documentation about running one-off commands.

```ruby
ADMIN_EMAIL=you@example.org bin/rails db:seed
```

A random password will be generated and printed out. You can change your password after logging in.

## Issues

If you run into any trouble, use the [SellRepo](https://github.com/excid3/sellrepo) issues and discussions for help.
