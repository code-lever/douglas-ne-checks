# Douglas::NE::Checks
[![Build Status](https://travis-ci.org/code-lever/douglas-ne-checks.png)](https://travis-ci.org/code-lever/douglas-ne-checks) [![Dependency Status](https://gemnasium.com/code-lever/douglas-ne-checks.png)](https://gemnasium.com/code-lever/douglas-ne-checks) [![Code Climate](https://codeclimate.com/github/code-lever/douglas-ne-checks.png)](https://codeclimate.com/github/code-lever/douglas-ne-checks)

Inspired by [@OpenNebraska](https://twitter.com/OpenNebraska)'s presentation @ [HOW Conf 2013](http://www.howconf.org), I figured I'd do a little civic hacking.

This gem will convert (as of the time of writing, of course) the [HTML dumps of supplier's checks](http://www.douglascountyclerk.org/supplierchecks) that the Douglas County Clerk's office provides weekly.

So instead of this: [example check dump](http://www.douglascountyclerk.org/images/stories/4-1-2014%20Supplier%20Checks%20by%20Dept.htm).

We can have a decent API, and if you want the fire hose you can have this (Ruby Hash):

    {
      :funds => [
        [0] {
          :name => "11111 - GENERAL",
          :organizations => [
            [0] {
              :name => "501012 - GENERAL OFFICE ASSESSOR",
              :entries => [
                [0] {
                  :supplier => "DOT COMM",
                  :account => "42541 - VOICE COMMUNICATIONS SERVICES(LOCAL&LONG DISTANCE)",
                  :description => "DOT.Comm - RSI - Chargeback/Quotation 2339",
                  :invoice => "90868",
                  :check_number => 355797,
                  :check_date => #<Date: 2013-06-04 ((2456448j,0s,0n),+0s,2299161j)>,
                  :check_status => "NEGOTIABLE",
                  :amount => 375.0
                }
              ]
            },
          ]

          # ...

        }
      ]
    }

Where the basic structure is:

    {
      :funds => [ {
        :name => 'Fund Name 1',
        :organizations => [ {
          :name => 'Organization 1',
          :entries => [
            { entry 0 },
            { entry 1 }
          ]
        } ]
      },
      # ...
      ]
    }

## Installation

Add this line to your application's Gemfile:

    gem 'douglas-ne-checks'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install douglas-ne-checks

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
