# Deploying to Production

You can deploy SellRepo with Kamal, Heroku, Render, Fly, Hatchbox.io, or your preferred method.

## Payments in production

First, you'll need your Stripe production [secret key](https://dashboard.stripe.com/apikeys).

Second, you'll need to set up production webhooks to `https://YOURDOMAIN.com/paywebhooks/stripe`
After creating the production webhook, Stripe will provide a signing secret which you'll set as the `STRIPE_SIGNING_SECRET` environment variable or in the Rails credentials.

The signing secret is used to ensure webhooks received came securely from Stripe.

## GitHub Token

Create a GitHub token with the following settings:

1. Expiration

We recommend 90 days or 1 year expiration. You will need to update this key periodically.

2. Repositories

Select the repositories you plan to sell or All repositories.

![GitHub token repositories](../app/assets/images/sellrepo/github-token-repositories.png)

3. Permissions

Under "Administration" set "Read & Write" access. This is required to add customers to your GitHub repositories.

![GitHub token permissions](../app/assets/images/sellrepo/github-token-permissions.png)

### Sending email in production

By default, SellRepo is configured to use SMTP for sending emails. To configure your transactional email service, set the following environment variables with the details from your email provider.

```bash
SMTP_HOST=smtp.example.com
SMTP_DOMAIN=yourdomain.com
SMTP_USERNAME=username
SMTP_PASSWORD=password
```

You can change this in `config/environments/production.rb` to use another email service if you prefer.

## Configuration

SellRepo requires some configuration to run in production. We recommend using environment variables but if you're familiar with Rails, you can use Rails credentials.

### Environment Variables (Recommended)

Set the following environment variables on the app at your hosting provider to configure SellRepo.

```bash
SMTP_HOST=smtp.example.com
SMTP_DOMAIN=yourdomain.com
SMTP_USERNAME=username
SMTP_PASSWORD=password

GITHUB_TOKEN=abcd

STRIPE_PRIVATE_KEY=sk_12345
STRIPE_SIGNING_SECRET=whsec_12345
```

### Rails Credentials

If you're familiar with Rails, you can use the Rails credentials as an alternative.

```bash
rails credentials:edit --environment=production
```

Then define the options in YAML:

```yaml
smtp:
  host: smtp.example.com
  domain: yourdomain.com
  username: username
  password: password

github:
  token: abcdefg

stripe:
  private_key: sk_test_1234
  signing_secret: whsec_12345
```

After saving this file, copy the contents of `config/credentials/production.key` to a safe place.

Then add `RAILS_MASTER_KEY` as an environment variable on your production application. Set the value of this environment variable to the contents of `config/credentials/production.key`.

## Create an admin user

Once deployed, you'll need to create an admin user in your production database. See your hosting provider's documentation about running one-off commands.

```ruby
ADMIN_EMAIL=you@example.org bin/rails db:seed
```

A random password will be generated and printed out. You can change your password after logging in and adding your SMTP credentials.
