module OpenTracing
  class NoopTracer
    # Start a new span
    # @param operation_name [String] The name of the operation represented by the span
    # @param child_of [Span] A span to be used as the ChildOf reference
    # @param start_time [Time] the start time of the span
    # @param tags [Hash] Starting tags for the span
    def start_span(operation_name, child_of: nil, start_time: nil, tags: nil)
      Span::NOOP_INSTANCE
    end
  end
end
