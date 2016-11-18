require "forwardable"
require "concurrent"
require "opentracing/version"
require "opentracing/span_context"
require "opentracing/span"
require "opentracing/tracer"

module OpenTracing
  # Text format for #inject and #extract
  FORMAT_TEXT_MAP = 1

  # Binary format for #inject and #extract
  FORMAT_BINARY = 2

  # Ruby Specific format to handle how Rack changes environment variables.
  # See Readme.md for more info.
  FORMAT_RACK = 3

  class << self
    extend Forwardable
    # Global tracer to be used when OpenTracing.start_span is called
    attr_accessor :global_tracer
    def_delegator :global_tracer, :start_span
  end
end
