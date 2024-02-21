# Gumroad API

This Ruby gem provides a simple interface to interact with the [Gumroad API](https://app.gumroad.com/api).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gumroad-api'
```

## Configuration

Before using the Gumroad API, you must configure it with your Gumroad access token. 
This token is required for authenticating your requests to the Gumroad API.

```ruby
Gumroad::Client.access_token = 'your_access_token_here'
```

## Usage

#### Listing Products

```ruby
products = Gumroad::Product.list
```

See the [Documentation](docs/index.md) for more details.

# Coverage

Not all endpoints are covered yet. Here is the list of what is covered and what is not:

- [x] Products
- [ ] Variant Categories
- [ ] Offer codes
- [ ] Custom Fields
- [ ] User
- [ ] Resource Subscriptions
- [x] Sales
- [ ] Subscribers
- [ ] Licenses

You can use the unimplemented endpoints as:

```ruby
Gumroad::Client.get('/products/123/subscribers')
Gumroad::Client.post('/products/123/custom_fields', body: { name: 'field_name', type: 'text' })
```

# Development

After checking out the repo, run bin/setup to install dependencies. Then, run rake spec to run the tests. You can also run bin/console for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run bundle exec rake install.

# Contributing

Bug reports and pull requests are welcome on GitHub. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the code of conduct.

# License

The gem is available as open source under the terms of the MIT License.