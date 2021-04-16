# SimpleHdGraph

parse single-tier hierarchy, simplex direction graph from YAML DSL, render PlantUML.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple-hd-graph'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple-hd-graph

## Usage

    $ simple-hd-graph -f FILE

## Example

input

```yaml
id: example1
resources:
  web:
    hosting: Heroku
    runtime: Ruby 2.5
    has:
      - admin
      - storage
  admin:
    hosting: Google Spreadsheet
    runtime: Google Apps Script
  storage:
    hosting: AWS S3
    region: ap-north-east1
```

output

```plantuml
rectangle "example1" as example1 {
  object "web" as example1Web {
    hosting: Heroku
    runtime: Ruby 2.5
  }
  object "admin" as example1Admin {
    hosting: Google Spreadsheet
    runtime: Google Apps Script
  }
  object "storage" as example1Storage {
    hosting: AWS S3
    region: ap-north-east1
  }

  example1Web -d-|> example1Admin
  example1Web -d-|> example1Storage
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wtnabe/graph.
