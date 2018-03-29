require 'test_helper'

module OpenTracing
  class ScopeManagerTest < Minitest::Test
    def setup
      @scope_manager = ScopeManager.new
    end

    def test_activate
      span = Span::NOOP_INSTANCE
      scope = @scope_manager.activate(span)
      assert_equal span, scope.span
    end

    def test_active
      span = Span::NOOP_INSTANCE
      scope = @scope_manager.activate(span)
      assert_equal scope, @scope_manager.active
    end
  end
end
