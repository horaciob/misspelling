
# Misspelling
It helps to find misspellings based on https://en.wikipedia.org/wiki/Wikipedia:Lists_of_common_misspellings/For_machines

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'misspelling', group: :development
```

And then execute:

    $ bundle exec misspelling

Or install it yourself as:

    $ gem install misspelling

## Usage

example.rb [options]

Specific options:
    -i pattern1,pattern2,..patternN, Included pattern will be added to paths
        --include
    -e pattern1,pattern2,...patternN,
        --exclude                    If specified, it excludes files matching the given filename pattern from the search.
Note that --exclude patterns take priority over --include patterns
    -c, --config_file file           Specify configuration file. By default will look for .misspelling.yml
    -h, --help                       Show this message
        --version                    Show version

or you can add a config file (.misspelling.yml by default) with this [format](https://github.com/horaciob/misspelling/blob/master/config/misspelling.yml)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/horaciob/misspelling.
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

