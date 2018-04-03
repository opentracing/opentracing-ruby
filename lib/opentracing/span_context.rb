module OpenTracing
  # SpanContext holds the data for a span that gets inherited to child spans
  class SpanContext
    NOOP_INSTANCE = SpanContext.new.freeze

    attr_reader :baggage

    # Create a new SpanContext
    # @param id the ID of the Context
    # @param trace_id the ID of the current trace
    # @param baggage baggage
    def initialize(baggage: {}); end
  end
end
