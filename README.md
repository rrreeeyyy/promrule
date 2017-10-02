# Promrule

Promrule is a tool to manage Prometheus alert/record rule.

It defines the state of Prometheus alert/record rule using DSL.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'promrule'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install promrule

## Usage

```
$ promrule -g -f examples/Alertfile
```

If you wrote below Alertfile and then execute above commands,

```
# -*- mode: ruby -*-
# vi: set ft=ruby :

groups do |*|
  name "my-group-name"
  interval "30s"

  rules do |*|
    record "instance:errors:rate5m"
    expr "rate(errors_total[5m])"
  end

  rules do |*|
    record "instance:requests:rate5m"
    expr "rate(requests_total[5m])"
  end

  rules do |*|
    alert "HighErrors"
    expr "sum without(instance) (instance:errors:rate5m) / sum without(instance) (instance:requests:rate5m)"

    _for "5m"

    labels do
      severity "Critical"
    end

    annotations do
      description "stuff's happening with {{ $labels.service }}"
    end
  end
end
```

Promrule generates this valid prometheus rule file

```
---
groups:
- name: my-group-name
  interval: 30s
  rules:
  - record: instance:errors:rate5m
    expr: rate(errors_total[5m])
  - record: instance:requests:rate5m
    expr: rate(requests_total[5m])
  - alert: HighErrors
    expr: sum without(instance) (instance:errors:rate5m) / sum without(instance) (instance:requests:rate5m)
    for: 5m
    labels:
      severity: Critical
    annotations:
      description: stuff's happening with {{ $labels.service }}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/promrule. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Promrule project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/promrule/blob/master/CODE_OF_CONDUCT.md).
