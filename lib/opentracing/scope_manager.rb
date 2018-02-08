module OpenTracing
  # ScopeManager represents an OpenTracing ScopeManager
  #
  # See http://www.opentracing.io for more information.

  # The ScopeManager interface abstracts both the activation of Span instances
  # via ScopeManager#activate and access to an active Span/Scope via
  # ScopeManager#active

  class ScopeManager

    # Make a span instance active.
    #
    # @param span [Span] the span that should become active
    # @param finish_on_close [Boolean] whether span should automatically be
    #   finished when Scope#close is called
    # @return [Scope] instance to control the end of the active period for the
    #  Span. It is a programming error to neglect to call Scope#close on the
    #  returned instance.
    def activate(span, finish_on_close: true)
      Scope::NOOP_INSTANCE
    end

    # @return [Span] the currently active scope which can be used to access the
    # currently active span.
    #
    # If there is a non-null scope, its wrapped span becomes an implicit parent
    # (as Reference#CHILD_OF) of any newly-created span at Tracer#start_active or
    # Tracer#start time.
    def active
      Scope::NOOP_INSTANCE
    end
  end
end
