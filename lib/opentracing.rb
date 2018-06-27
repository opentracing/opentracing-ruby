require 'forwardable'
require 'opentracing/version'
require 'opentracing/span_context'
require 'opentracing/span'
require 'opentracing/reference'
require 'opentracing/tracer'
require 'opentracing/scope'
require 'opentracing/scope_manager'

#:nodoc:
module OpenTracing
  # Text format for Tracer#inject and Tracer#extract.
  #
  # The carrier for FORMAT_TEXT_MAP should be a Hash with string values.
  FORMAT_TEXT_MAP = 1

  # Binary format for #inject and #extract
  #
  # The carrier for FORMAT_BINARY should be a string, treated as a raw sequence
  # of bytes.
  FORMAT_BINARY = 2

  # Due to Rack's popularity within the Ruby community, OpenTracing-Ruby
  # provides a Rack-specific format for injection into and extraction from HTTP
  # headers specifically, though there are some strings attached.
  #
  # The carrier for FORMAT_RACK should be `env` or equivalent. It behaves like
  # FORMAT_TEXT_MAP, but with all keys transformed per Rack's treatment of HTTP
  # headers. Keep in mind that Rack automatically uppercases all headers and
  # replaces dashes with underscores. This means that if you use dashes and
  # underscores and case-sensitive baggage keys, they may collide or become
  # unrecognizable.
  FORMAT_RACK = 3

  class << self
    extend Forwardable
    # Global tracer to be used when OpenTracing.start_span, inject or extract is called
    attr_accessor :global_tracer
    def_delegators :global_tracer, :scope_manager, :start_active_span,
                   :start_span, :inject, :extract, :active_span
  end
end

# Default to the no-op tracer
OpenTracing.global_tracer = OpenTracing::Tracer.new
