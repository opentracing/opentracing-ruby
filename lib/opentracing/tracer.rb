module OpenTracing
  class Tracer
    # @return [ScopeManager] the current ScopeManager, which may be a no-op but
    #   may not be nil.
    def scope_manager
      ScopeManager::NOOP_INSTANCE
    end

    # Returns a newly started and activated Scope.
    #
    # If the Tracer's ScopeManager#active is not nil, no explicit references
    # are provided, and `ignore_active_scope` is false, then an inferred
    # References#CHILD_OF reference is created to the ScopeManager#active's
    # SpanContext when start_active is invoked.
    #
    # @param operation_name [String] The operation name for the Span
    # @param child_of [SpanContext, Span] SpanContext that acts as a parent to
    #        the newly-started Span. If a Span instance is provided, its
    #        context is automatically substituted. See [Reference] for more
    #        information.
    #
    #   If specified, the `references` parameter must be omitted.
    # @param references [Array<Reference>] An array of reference
    #   objects that identify one or more parent SpanContexts.
    # @param start_time [Time] When the Span started, if not now
    # @param tags [Hash] Tags to assign to the Span at start time
    # @param ignore_active_scope [Boolean] whether to create an implicit
    #   References#CHILD_OF reference to the ScopeManager#active.
    # @param finish_on_close [Boolean] whether span should automatically be
    #   finished when Scope#close is called
    # @return [Scope] The newly-started and activated Scope
    def start_active(operation_name,
                     child_of: nil,
                     references: nil,
                     start_time: Time.now,
                     tags: nil,
                     ignore_active_scope: false,
                     finish_on_close: true)
      Scope::NOOP_INSTANCE
    end

    # Like #start_active, but the returned Span has not been registered via the
    # ScopeManager.
    #
    # @param operation_name [String] The operation name for the Span
    # @param child_of [SpanContext, Span] SpanContext that acts as a parent to
    #        the newly-started Span. If a Span instance is provided, its
    #        context is automatically substituted. See [Reference] for more
    #        information.
    #
    #   If specified, the `references` parameter must be omitted.
    # @param references [Array<Reference>] An array of reference
    #   objects that identify one or more parent SpanContexts.
    # @param start_time [Time] When the Span started, if not now
    # @param tags [Hash] Tags to assign to the Span at start time
    # @param ignore_active_scope [Boolean] whether to create an implicit
    #   References#CHILD_OF reference to the ScopeManager#active.
    # @return [Span] the newly-started Span instance, which has not been
    #   automatically registered via the ScopeManager
    def start(operation_name,
              child_of: nil,
              references: nil,
              start_time: Time.now,
              tags: nil,
              ignore_active_scope: false)
      Span::NOOP_INSTANCE
    end

    # Starts a new span.
    #
    # @deprecated Use {#start_active} or {#start} instead.
    #
    # @param operation_name [String] The operation name for the Span
    # @param child_of [SpanContext, Span] SpanContext that acts as a parent to
    #        the newly-started Span. If a Span instance is provided, its
    #        context is automatically substituted. See [Reference] for more
    #        information.
    #
    #   If specified, the `references` paramater must be omitted.
    # @param references [Array<Reference>] An array of reference
    #   objects that identify one or more parent SpanContexts.
    # @param start_time [Time] When the Span started, if not now
    # @param tags [Hash] Tags to assign to the Span at start time
    # @return [Span] The newly-started Span
    def start_span(operation_name,
                   child_of: nil,
                   references: nil,
                   start_time: Time.now,
                   tags: nil)
      warn 'Tracer#start_span is deprecated and will be removed from opentracing-ruby'
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
    # @return [SpanContext, nil] the extracted SpanContext or nil if none could be found
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
