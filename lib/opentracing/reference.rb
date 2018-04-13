module OpenTracing
  #:nodoc:
  class Reference
    CHILD_OF = 'child_of'.freeze
    FOLLOWS_FROM = 'follows_from'.freeze

    # @param context [SpanContext, Span] child_of context refers to a
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
    # @return [Reference] a ChildOf reference
    #
    # @example
    #   root_span = OpenTracing.start_span('root operation')
    #   child_span = OpenTracing.start_span('child operation', references: [
    #     OpenTracing::Reference.child_of(root_span)
    #   ])
    #
    def self.child_of(context)
      context = context.context if context.is_a?(Span)
      Reference.new(CHILD_OF, context)
    end

    # @param context [SpanContext, Span] follows_from context refers to a
    #   parent Span that does not depend in any way on the result of the new
    #   child Span. For instance, one might use FollowsFrom Span to describe
    #   pipeline stages separated by queues, or a fire-and-forget cache insert
    #   at the tail end of a web request.
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
    # @return [Reference] a FollowsFrom reference
    #
    # @example
    #   context = OpenTracing.extract(OpenTracing::FORMAT_RACK, rack_env)
    #   span = OpenTracing.start_span('following operation', references: [
    #     OpenTracing::Reference.follows_from(context)
    #   ])
    #
    def self.follows_from(context)
      context = context.context if context.is_a?(Span)
      Reference.new(FOLLOWS_FROM, context)
    end

    def initialize(type, context)
      @type = type
      @context = context
    end

    # @return [String] reference type
    attr_reader :type

    # @return [SpanContext] the context of a span this reference is referencing
    attr_reader :context
  end
end
