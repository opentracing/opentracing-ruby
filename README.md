# OpenTracing API for Ruby

[![Build Status](https://travis-ci.org/ngauthier/opentracing-ruby.svg?branch=master)](https://travis-ci.org/ngauthier/opentracing-ruby) [![Code Climate](https://codeclimate.com/github/ngauthier/opentracing-ruby/badges/gpa.svg)](https://codeclimate.com/github/ngauthier/opentracing-ruby) [![Test Coverage](https://codeclimate.com/github/ngauthier/opentracing-ruby/badges/coverage.svg)](https://codeclimate.com/github/ngauthier/opentracing-ruby/coverage)

This package is a Ruby platform API for OpenTracing.

## Required Reading

In order to understand the Ruby platform API, one must first be familiar with the
[OpenTracing project](http://opentracing.io) and
[terminology](http://opentracing.io/documentation/pages/spec.html) more specifically.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'opentracing'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install opentracing

## Usage

Everyday consumers of this `opentracing` gem really only need to worry
about a couple of key abstractions: the `start_span` function, the `Span`
interface, and binding a `Tracer` at runtime. Here are code snippets
demonstrating some important use cases.

### Singleton initialization

As early as possible, call

```ruby
require 'opentracing'
OpenTracing.global_tracer = MyTracerImplementation.New(...)
```

Where `MyTracerImplementation` is your tracer. For testing, you can use
the provided `OpenTracing::NilTracer`

### Non-Singleton initialization

If you prefer direct control to singletons, manage ownership of the
`Tracer` implementation explicitly.

### Starting an empty trace by creating a "root span"

It's always possible to create a "root" `Span` with no parent or other causal
reference.

```ruby
span = OpenTracing.start_span("operation_name")
span.finish
```

This example will start a span on the global tracer (initialized above). If
you are managing your own tracer you'll need to call `start_span` on your
tracer.

### Creating a (child) Span given an existing (parent) Span

```ruby
span = OpenTracing.start_span("parent")
child = OpenTracing.start_span("child", child_of: span)
child.finish
span.finish
```

### Serializing to the wire

```ruby
client = Net::HTTP.new("http://myservice")
req = Net::HTTP::Post.new("/")

span = OpenTracing.start_span("my_span")
OpenTracing.inject(span.context, OpenTracing::FORMAT_RACK, env)
res = client.request(req)
#...
```

### Deserializing from the wire

The OpenTracing Ruby gem provides a specific Rack header extraction format,
since most Ruby web servers get their HTTP Headers from Rack. Keep in mind that
Rack automatically uppercases all headers and replaces dashes with underscores.
This means that if you use dashes and underscores and case-sensitive baggage,
it will not be possible to discern once Rack has processed it.

```ruby
class MyRackApp
  def call(env)
    extracted_ctx = @tracer.extract(OpenTracing::FORMAT_RACK, env)
    span = @tracer.start_span("my_app", child_of: extracted_ctx)
    span.finish
    [200, {}, ["hello"]]
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/opentracing/opentracing-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
