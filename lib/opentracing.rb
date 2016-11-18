require "forwardable"
require "concurrent"
require "opentracing/version"
require "opentracing/span_context"
require "opentracing/span"
require "opentracing/noop_tracer"

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

    # Inject a span into the given carrier
    # @param span_context [SpanContext]
    # @param format [OpenTracing::FORMAT_TEXT_MAP, OpenTracing::FORMAT_BINARY, OpenTracing::FORMAT_RACK]
    # @param carrier [Hash]
    def inject(span_context, format, carrier)
      case format
      when OpenTracing::FORMAT_TEXT_MAP, OpenTracing::FORMAT_BINARY, OpenTracing::FORMAT_RACK
        return nil
      else
        warn 'Unknown inject format'
      end
    end

    # Extract a span from a carrier
    # @param operation_name [String]
    # @param format [OpenTracing::FORMAT_TEXT_MAP, OpenTracing::FORMAT_BINARY, OpenTracing::FORMAT_RACK]
    # @param carrier [Hash]
    # @param tracer [Tracer] the tracer the span will be attached to (for finish)
    # @return [Span]
    def extract(operation_name, format, carrier, tracer)
      case format
      when OpenTracing::FORMAT_TEXT_MAP, OpenTracing::FORMAT_BINARY, OpenTracing::FORMAT_RACK
        return SpanContext::NOOP_INSTANCE
      else
        warn 'Unknown extract format'
        nil
      end
    end
  end
end
