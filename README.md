# RailsUpgradeTracker
make upgrading rails a little easier


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails-upgrade-tracker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails-upgrade-tracker

## Usage

```ruby
require 'rails-upgrade-tracker'

rails_version = '4.0.0'
tracker = RailsUpgradeTracker::Base.new(rails_version)
path_to_gemfile = './Gemfile'
gem_names = tracker.collect_gems_from_gemfile(path_to_gemfile)

tracker.rails_data['number'] == '4.0.0'
tracker.rails_version == '4.0.0'
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/rails-upgrade-tracker/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
