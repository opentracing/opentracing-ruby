module OpenTracing
  class Tracer
    # Start a new span
    # @param operation_name [String] The name of the operation represented by the span
    # @param child_of [Span] A span to be used as the ChildOf reference
    # @param start_time [Time] the start time of the span
    # @param tags [Hash] Starting tags for the span
    def start_span(operation_name, child_of: nil, start_time: nil, tags: nil)
      Span::NOOP_INSTANCE
    end


    # Inject a span into the given carrier
    # @param span_context [SpanContext]
    # @param format [OpenTracing::FORMAT_TEXT_MAP, OpenTracing::FORMAT_BINARY, OpenTracing::FORMAT_RACK]
    # @param carrier [Carrier]
    def inject(span_context, format, carrier)
      case format
      when OpenTracing::FORMAT_TEXT_MAP, OpenTracing::FORMAT_BINARY, OpenTracing::FORMAT_RACK
        return nil
      else
        warn 'Unknown inject format'
      end
    end

    # Extract a span from a carrier
    # @param format [OpenTracing::FORMAT_TEXT_MAP, OpenTracing::FORMAT_BINARY, OpenTracing::FORMAT_RACK]
    # @param carrier [Carrier]
    # @return [SpanContext]
    def extract(format, carrier)
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
