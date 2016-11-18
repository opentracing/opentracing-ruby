require 'test_helper'

class NoopTracerTest < Minitest::Test
  def test_start_span
    assert_equal OpenTracing::Span::NOOP_INSTANCE, OpenTracing::NoopTracer.new.start_span("operation_name")
  end
end
