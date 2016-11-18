require "forwardable"
require "concurrent"
require "opentracing/version"
require "opentracing/span_context"
require "opentracing/span"
require "opentracing/nil_tracer"

module OpenTracing
  FORMAT_TEXT_MAP = 1
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
        return carrier
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
        return SpanContext.new()
      else
        warn 'Unknown extract format'
        nil
      end
    end
  end
end
