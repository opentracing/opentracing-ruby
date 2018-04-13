module OpenTracing
  # Scope represents an OpenTracing Scope
  #
  # See http://www.opentracing.io for more information.
  class Scope
    NOOP_INSTANCE = Scope.new.freeze

    # Return the Span scoped by this Scope
    #
    # @return [Span]
    def span
      Span::NOOP_INSTANCE
    end

    # Mark the end of the active period for the current thread and Scope,
    # updating the ScopeManager#active in the process.
    #
    # NOTE: Calling close more than once on a single Scope instance leads to
    # undefined behavior.
    def close; end
  end
end
