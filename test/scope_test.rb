require 'test_helper'

module OpenTracing
  class ScopeTest < Minitest::Test
    def test_span
      span = Span::NOOP_INSTANCE
      scope = Scope.new
      assert_equal span, scope.span
    end

    def test_close
      scope = Scope.new
      scope.close
    end
  end
end
