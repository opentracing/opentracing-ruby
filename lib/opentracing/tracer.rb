module OpenTracing
  class Tracer
    # Starts a new span.
    #
    # @param operation_name [String] The operation name for the Span
    #
    # @param child_of [SpanContext, Span] child_of (ChildOf) refers to a
    #   parent Span that caused *and* somehow depends upon the new child Span.
    #   Often (but not always), the parent Span cannot finish until the child
    #   Span does.
    #
    #   An timing diagram for a child Span that is blocked on the new Span:
    #
    #     [-Parent Span----------]
    #          [-Child Span----]
    #
    #   See http://opentracing.io/documentation/pages/spec
    #
    # @param follows_from [SpanContext, Span] follows_from (FollowsFrom)
    #   refers to a parent Span that does not depend in any way on the result
    #   of the new child Span. For instance, one might use FollowsFrom Span to
    #   describe pipeline stages separated by queues, or a fire-and-forget
    #   cache insert at the tail end of a web request.
    #
    #   A FollowsFrom Span is part of the same logical trace as the new Span:
    #   i.e., the new Span is somehow caused by the work of its FollowsFrom
    #   Span.
    #
    #   All of the following could be valid timing diagrams for children that
    #   "FollowFrom" a parent:
    #
    #     [-Parent Span--]  [-Child Span-]
    #
    #     [-Parent Span--]
    #      [-Child Span-]
    #
    #     [-Parent Span-]
    #                [-Child Span-]
    #
    #   See http://opentracing.io/documentation/pages/spec
    #
    # @param start_time [Time] When the Span started, if not now
    #
    # @param tags [Hash] Tags to assign to the Span at start time
    #
    # @return [Span] The newly-started Span
    def start_span(operation_name, child_of: nil, follows_from: nil, start_time: Time.now, tags: nil)
      Span::NOOP_INSTANCE
    end

    # Inject a SpanContext into the given carrier
    #
    # @param span_context [SpanContext]
    # @param format [OpenTracing::FORMAT_TEXT_MAP, OpenTracing::FORMAT_BINARY, OpenTracing::FORMAT_RACK]
    # @param carrier [Carrier] A carrier object of the type dictated by the specified `format`
    def inject(span_context, format, carrier)
      case format
      when OpenTracing::FORMAT_TEXT_MAP, OpenTracing::FORMAT_BINARY, OpenTracing::FORMAT_RACK
        return nil
      else
        warn 'Unknown inject format'
      end
    end

    # Extract a SpanContext in the given format from the given carrier.
    #
    # @param format [OpenTracing::FORMAT_TEXT_MAP, OpenTracing::FORMAT_BINARY, OpenTracing::FORMAT_RACK]
    # @param carrier [Carrier] A carrier object of the type dictated by the specified `format`
    # @return [SpanContext] the extracted SpanContext or nil if none could be found
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
