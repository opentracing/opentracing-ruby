require 'test_helper'

class SpanTest < Minitest::Test
  def test_attributes
    span.operation_name = "foo"
    OpenTracing::Span::NOOP_INSTANCE.operation_name = "bar"
  end

  def test_context
    assert_equal OpenTracing::SpanContext::NOOP_INSTANCE, span.context
  end

  def test_tags
    span.set_tag("foo", "bar")
  end

  def test_baggage
    span.set_baggage_item(:foo, :bar)
    assert_nil span.get_baggage_item(:foo)
  end

  def test_log
    assert_nil span.log(event: "event", timestamp: Time.now, foo: "bar")
  end

  def test_finish
    span.finish(end_time: Time.now)
  end

  private

  def span
    tracer = Minitest::Mock.new
    context = OpenTracing::SpanContext.new
    OpenTracing::Span.new(tracer, context)
  end
end
