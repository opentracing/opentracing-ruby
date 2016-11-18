require 'test_helper'

class SpanContextTest < Minitest::Test
  def test_create
    OpenTracing::SpanContext.new
  end
end
