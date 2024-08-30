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

Run `bin/rails sellrepo:admin` to create an admin user and enter your email:

```ruby
bin/rails sellrepo:admin
```

A random password will be generated and printed out. You can change your password after logging in.

### Configure your store

#### GitHub Tokens

Create a new GitHub Token to add customers to repositories.

1. Set the Expiration to as long as you would like. For example, 90 days or 1 year are good options so you don't have to update it often.
2. Choose the repositories this token has access to. We recommend choosing the specific repositories you wish to sell.
3. Add the Administration Read & Write permission.
4. Save a copy of the token somewhere safe.
5. Add to SellRepo

You can set the `GITHUB_TOKEN=abcd` environment variable and restart your Rails application or use Rails credentials.

For Rails credentials, use `bin/rails credentials:edit --environment=development`

```yaml
github:
  token: sk_test_1234
```

#### Payments

##### Stripe (Recommended)

To test payments locally, you'll need to provide the Stripe test environment secret key. This can be done in env vars or with Rails credentials.

```bash
STRIPE_PRIVATE_KEY=sk_test_1234 bin/rails server
```

Or with Rails credentials, use environment credentials `bin/rails credentials:edit --environment=development`

```yaml
stripe:
  private_key: sk_test_1234
```

For development, Stripe webhooks can be forwarded to Rails by using the [Stripe CLI](https://docs.stripe.com/stripe-cli). This helps keep local payments data in sync (like if a subscription is canceled or a payment is refunded) to reflect those changes.

```bash
stripe listen --forward-to localhost:3000/webhooks/stripe
```

##### LemonSqueezy (Beta)

> [!WARNING]
> LemonSqueezy support is in beta.

To test payments locally, you'll need to provide the Stripe test environment secret key. This can be done in env vars or with Rails credentials.

```bash
LEMON_SQUEEZY_STORE_ID=1234 LEMON_SQUEEZY_API_KEY=sk_test_1234 bin/rails server
```

Or with Rails credentials, use environment credentials `bin/rails credentials:edit --environment=development`

```yaml
lemon_squeezy:
  store_id: 1234
  api_key: sk_test_1234
```

For development, webhooks can be forwarded to Rails by using [localtunnel](https://theboroer.github.io/localtunnel-www/), ngrok, or a similar tool. This helps keep local payments data in sync (like if a subscription is canceled or a payment is refunded) to reflect those changes.

```bash
lt --port 3000
```
