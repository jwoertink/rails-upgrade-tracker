# RailsUpgradeTracker
make upgrading rails a little easier.

The idea is that you want to do incremental updates to rails, but by the time you get to the next version, rails has been updated 20 times, and some of the gems you use are no longer supported. I want a way to specify a rails version, and have something tell me all the versions of the gems I'm using that will go with that version of rails.

Currently this gem does a best guess at saying if the gem version is within 120 days after or 1 year before of that rails' version release then it is most likely ok to use. This obviously makes a ton of assumptions, but if it gets you close, then that will make upgrading rails a little easier.

In the future, it would be nice to have some list that tells you gems that best work with that version of rails. i.e. `themes_for_rails` is great for rails 3.x and `themes_on_rails` is great for rails 4.x. 


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
