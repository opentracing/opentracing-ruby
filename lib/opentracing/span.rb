module OpenTracing
  # Span represents an OpenTracing Span
  #
  # See http://www.opentracing.io for more information.
  class Span
    NOOP_INSTANCE = Span.new.freeze

    # Set the name of the operation
    #
    # @param [String] name
    def operation_name=(name)
    end

    # Span Context
    #
    # @return [SpanContext]
    def context
      SpanContext::NOOP_INSTANCE
    end

    # Set a tag value on this span
    # @param key [String] the key of the tag
    # @param value [String, Numeric, Boolean] the value of the tag. If it's not
    # a String, Numeric, or Boolean it will be encoded with to_s
    def set_tag(key, value)
      self
    end

    # Set a baggage item on the span
    # @param key [String] the key of the baggage item
    # @param value [String] the value of the baggage item
    def set_baggage_item(key, value)
      self
    end

    # Get a baggage item
    # @param key [String] the key of the baggage item
    # @return [String] value of the baggage item
    def get_baggage_item(key)
      nil
    end

    # Add a log entry to this span
    # @param event [String] event name for the log
    # @param timestamp [Time] time of the log
    # @param fields [Hash] Additional information to log
    def log(timestamp: Time.now, **fields)
      nil
    end

    # Finish the {Span}
    # @param end_time [Time] custom end time, if not now
    def finish(end_time: Time.now)
      nil
    end
  end
end
