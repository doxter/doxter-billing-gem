# DoxterBilling-Gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'doxter_billing'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install doxter_billing

## Usage
You need to define ENV-Variables DOXTER_BILLING_API_USER and DOXTER_BILLING_API_PASSWORD

    DoxterBilling::Subscription.all
    
    DoxterBilling::Subscription.since('sync_token')

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment. 

To install this gem onto your local machine, run `bundle exec rake install`. 

## Contributing

1. Fork it ( https://github.com/[my-github-username]/doxter_billing/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
