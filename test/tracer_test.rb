require 'test_helper'

class TracerTest < Minitest::Test
  def test_start_span
    assert_equal OpenTracing::Span::NOOP_INSTANCE, OpenTracing::Tracer.new.start_span("operation_name")
  end

  def test_start_span_allows_references
    references = [OpenTracing::Reference.child_of(OpenTracing::Span::NOOP_INSTANCE)]
    assert_equal OpenTracing::Span::NOOP_INSTANCE,
      OpenTracing::Tracer.new.start_span("operation_name", references: references)
  end

  def test_start_active_span
    scope = OpenTracing::Tracer.new.start_active_span("operation_name")
    assert_equal OpenTracing::Scope::NOOP_INSTANCE, scope
    assert_equal OpenTracing::Span::NOOP_INSTANCE, scope.span
  end

  def test_start_active_span_allows_references
    references = [OpenTracing::Reference.child_of(OpenTracing::Span::NOOP_INSTANCE)]
    scope = OpenTracing::Tracer.new.start_active_span("operation_name", references: references)
    assert_equal OpenTracing::Scope::NOOP_INSTANCE, scope
    assert_equal OpenTracing::Span::NOOP_INSTANCE, scope.span
  end

  def test_start_active_span_accepts_block
    OpenTracing::Tracer.new.start_active_span("operation_name") do |scope|
      assert_equal OpenTracing::Scope::NOOP_INSTANCE, scope
      assert_equal OpenTracing::Span::NOOP_INSTANCE, scope.span
    end
  end

  def test_inject_text_map
    context = OpenTracing::SpanContext::NOOP_INSTANCE
    carrier = {}
    tracer.inject(context, OpenTracing::FORMAT_TEXT_MAP, carrier)
  end

  def test_inject_binary
    tracer.inject(nil, OpenTracing::FORMAT_BINARY, nil)
  end

  def test_inject_rack
    context = OpenTracing::SpanContext::NOOP_INSTANCE
    tracer.inject(context, OpenTracing::FORMAT_RACK, {})
  end

  def test_invalid_inject_format
    assert_warn "Unknown inject format\n" do
      tracer.inject(nil, 9999, nil)
    end
  end

  def test_extract_text_map
    span = tracer.extract(OpenTracing::FORMAT_TEXT_MAP, {})
  end

  def test_extract_binary
    tracer.extract(OpenTracing::FORMAT_BINARY, nil)
  end

  def test_extract_rack
    tracer.extract(OpenTracing::FORMAT_RACK, {})
  end

  def test_extract_unknown
    assert_warn "Unknown extract format\n" do
      tracer.extract(999, nil)
    end
  end

  def test_scope_manager
    assert_equal OpenTracing::ScopeManager::NOOP_INSTANCE, tracer.scope_manager
  end

  private
  def tracer
    OpenTracing::Tracer.new
  end
end
