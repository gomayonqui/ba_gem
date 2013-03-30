# Ba

Bank Account Gem!

  This Gem was created to help you get information from
  your bank account from your console

## Currently Supported Banks
    Bancolombia
    Payoneer (work in progress)

## Installation

Add this line to your application's Gemfile:

    gem 'ba'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ba

## Usage

### Checkout the different commands by running
    $ ba

### Install
    Run the following command if you don't have any config/config.yml file in your local path

    $ ba install

### Modify the ~/config/config.yml with your bank info
    $ vi ~/config/config.yml

### Run the command for your bank
    $ ba [BANK] balance

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### Adding new Scripts
    - Follow the bank.sample.rb example
    - Add the bank to the config/config.sample.yml
    - Push it!

## CONTRIBUTORS
    Bancolombia Script      =>    Jean Pierre(@gomayonqui)
