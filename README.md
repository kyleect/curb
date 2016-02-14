# Curb

Curb is a learning excercise implementing a gherkin parser and test runner.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'curb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install curb

## Usage

1. Write gerkin in to `features/**/*.feature` files
2. Define step handlers in `features/steps/**/*.rb`

### Gherkin/Feature Files

```gherkin
# ./features/login.feature

Feature: Login
Scenario: Login sucessfully
Given I am not logged in
When I login with valid credentials
Then I was able to login
```

### Step Handlers

```ruby
# ./features/steps/login_steps.rb

handlers = []

handlers << Curb::StepHandler.new(/I (am|am not) logged in/) do |logged_in|
	# Setup authentication state based on logged_in
end

handlers << Curb::StepHandler.new(/I login with (valid|invalid) credentials/) do |are_valid|
	# Fill out login form with valid/invalid credentials
	# Submit login form
end

handlers << Curb::StepHandler.new(/I (was|was not) able to login/) do |name|
	# Assert login was/wasn't successful
end

# Register handler to the Runner instance
Curb::Runner.instance.add_handlers(handlers)
```

### Run tests

Run the `curb` command in your project's root directory

    $ curb

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kyleect/curb.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

