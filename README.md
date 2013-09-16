# Douglas::NE::Checks
[![Build Status](https://travis-ci.org/code-lever/douglas-ne-checks.png)](https://travis-ci.org/code-lever/douglas-ne-checks) [![Dependency Status](https://gemnasium.com/code-lever/douglas-ne-checks.png)](https://gemnasium.com/code-lever/douglas-ne-checks) [![Code Climate](https://codeclimate.com/github/code-lever/douglas-ne-checks.png)](https://codeclimate.com/github/code-lever/douglas-ne-checks)

Inspired by [@OpenNebraska](https://twitter.com/OpenNebraska)'s presentation @ [HOW Conf 2013](http://www.howconf.org), I figured I'd do a little civic hacking.

This gem will convert (as of the time of writing, of course) the [HTML dumps of supplier's checks](http://www.douglascountyclerk.org/supplierchecks) that the Douglas County Clerk's office provides weekly.

So instead of this: [2013-09-10 check dump](http://www.douglascountyclerk.org/images/stories/supplierchecks/2013-09-10%20Supplier%20Checks%20by%20dept.htm).

We can have this:

    {
      "11111 - GENERAL" => {
        "501015 - REAL ESTATE APPRAISE" => [
          [0] {
            :supplier => "COSTAR REALTY INFORMATION INC",
            :account => "42411 - MAINTENANCE CONTRACT",
            :description => "COSTAR GROUP, INC - Inv. 102152750 (August)",
            :invoice => "102152750",
            :check_number => 363593,
            :check_date => #<Date: 2013-09-10 ((2456546j,0s,0n),+0s,2299161j)>,
            :check_status => "NEGOTIABLE",
            :amount => 500.0
          }
        ],
        "502011 - ADMIN COUNTY CLERK" => [
          [0] {
            :supplier => "TOSHIBA FINANCIAL SERVICES",
            :account => "42471 - LEASE COPY MACHINES",
            :description => "CO CLERK S/N CEI02847 ESTUDIO 855/CONTRACT 500-279467-000",
            :invoice => "233826767",
            :check_number => 363494,
            :check_date => #<Date: 2013-09-10 ((2456546j,0s,0n),+0s,2299161j)>,
            :check_status => "NEGOTIABLE",
            :amount => 334.72
          }
        ],
        "502012 - RECORDS COUNTY CLERK" => [
          [0] {
            :supplier => "DOT COMM",
            :account => "42411 - MAINTENANCE CONTRACT",
            :description => "PSI Capture annual maintenance.",
            :invoice => "93311",
            :check_number => 363484,
            :check_date => #<Date: 2013-09-10 ((2456546j,0s,0n),+0s,2299161j)>,
            :check_status => "NEGOTIABLE",
            :amount => 575.0
          }
        ],
        # ...
      }
      # ...
    }

Where the basic structure is:

    {
      "FUND 1" => {
        "ORGANIZATION 1" => [
          [0] { entry 0 },
          [1] { entry 0 }
        ],
        "ORGANIZATION 2" => [
          [0] { entry 0 }
        ],
      }
      "FUND 2" => { ... }
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
