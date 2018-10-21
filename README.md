# OpenTracing API for Ruby

[![Build Status](https://travis-ci.org/ngauthier/opentracing-ruby.svg?branch=master)](https://travis-ci.org/ngauthier/opentracing-ruby) [![Code Climate](https://codeclimate.com/github/ngauthier/opentracing-ruby/badges/gpa.svg)](https://codeclimate.com/github/ngauthier/opentracing-ruby) [![Test Coverage](https://codeclimate.com/github/ngauthier/opentracing-ruby/badges/coverage.svg)](https://codeclimate.com/github/ngauthier/opentracing-ruby/coverage)

This package is a Ruby platform API for OpenTracing.

## Required Reading

In order to understand the Ruby platform API, one must first be familiar with the
[OpenTracing project](https://opentracing.io) and
[terminology](https://opentracing.io/docs/overview/) more specifically.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'opentracing'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install opentracing

`opentracing` supports Ruby 2.0+.

## Usage

Everyday consumers of this `opentracing` gem really only need to worry
about a couple of key abstractions: the `start_active_span` and `start_span`
methods, the `Span` and `ScopeManager` interfaces, and binding a `Tracer`
at runtime. Here are code snippets demonstrating some important use cases.

### Singleton initialization

As early as possible, call

```ruby
require 'opentracing'
OpenTracing.global_tracer = MyTracerImplementation.new(...)
```

Where `MyTracerImplementation` is your tracer. For testing, you can use
the provided `OpenTracing::Tracer`

### Non-Singleton initialization

If you prefer direct control to singletons, manage ownership of the
`Tracer` implementation explicitly.

### Scopes and within-process propagation

For any thread, at most one `Span` may be "active". Of course there may be many
other `Spans` involved with the thread which are (a) started, (b) not finished,
and yet (c) not "active": perhaps they are waiting for I/O, blocked on a child
`Span`, or otherwise off of the critical path.

It's inconvenient to pass an active `Span` from function to function manually,
so OpenTracing requires that every `Tracer` contains a `ScopeManager` that
grants access to the active `Span` through a `Scope`. Any `Span` may be
transferred to another callback or thread, but not `Scope`.

#### Accessing the active Span through Scope

```ruby
# Access to the active span is straightforward.

span = OpenTracing.active_span
if span
  span.set_tag('...', '...')
end

# or

scope = OpenTracing.scope_manager.active
if scope
  scope.span.set_tag('...', '...')
end
```

### Starting a new Span

The common case starts a `Scope` that's automatically registered for
intra-process propagation via `ScopeManager`.

Note that `start_active_span('...')` automatically finishes the span on
`Scope#close` (`start_active_span('...', finish_on_close: false)` does not
finish it, in contrast).

```ruby
# Automatic activation of the Span.
# By default the active span will be finished when the returned scope is closed.
# This can be controlled by passing finish_on_close parameter to
# start_active_span
scope = OpenTracing.start_active_span('operation_name')
# Do things.

# Block form of start_active_span
# start_active_span optionally accepts a block. If a block is passed to
# start_active_span it will yield the newly created scope. The scope will
# be closed and its associated span will be finished unless
# finish_on_close: false is passed to start_active_span.
OpenTracing.start_active_span('operation_name') do |scope|
# Do things.
end

# Manual activation of the Span.
# Spans can be managed manually. This is equivalent to the more concise examples
# above.
span = OpenTracing.start_span('operation_name')
OpenTracing.scope_manager.activate(span)
scope = OpenTracing.scope_manager.active
# Do things.

# If there is an active Scope, it will act as the parent to any newly started
# Span unless ignore_active_scope: true is passed to start_span or
# start_active_span.

# create a root span, ignoring the currently active scope (if it's set)
scope = OpenTracing.start_active_span('operation_name', ignore_active_scope: true)

# or
span = OpenTracing.start_span('operation_name', ignore_active_scope: true)

# It's possible to create a child Span given an existing parent Span by
# using the child_of option.

parent_scope = OpenTracing.start_active_span('parent_operation, ignore_active_scope: true)
child_scope = OpenTracing.start_active_span('child_operation', child_of: parent_scope.span)

# or
parent_span = OpenTracing.start_span('parent_operation', ignore_active_scope: true)
child_span = OpenTracing.start_span('child_operation', child_of: parent_span)

```

### Serializing to the wire

Using `Net::HTTP`:
```ruby
client = Net::HTTP.new("myservice.com")
req = Net::HTTP::Post.new("/")

span = OpenTracing.start_span("my_span")
OpenTracing.inject(span.context, OpenTracing::FORMAT_RACK, req)
res = client.request(req)
#...
```

Using Faraday middleware:
```ruby
class TraceMiddleware < Faraday::Middleware
  def call(env)
    span = OpenTracing.start_span("my_span")
    OpenTracing.inject(span.context, OpenTracing::FORMAT_RACK, env)
    @app.call(env).on_complete do
      span.finish
    end
  end
end
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

## Licensing

[Apache 2.0 License](./LICENSE).
