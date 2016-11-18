module OpenTracing
  class NilTracer
    # Start a new span
    # @param operation_name [String] The name of the operation represented by the span
    # @param child_of [Span] A span to be used as the ChildOf reference
    # @param start_time [Time] the start time of the span
    # @param tags [Hash] Starting tags for the span
    def start_span(operation_name, child_of: nil, start_time: nil, tags: nil)
    end

    # Finish a Span
    # @param span [Span] the span to finish
    def finish_span(span)
    end
  end
end
