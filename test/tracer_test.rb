require 'test_helper'

class TracerTest < Minitest::Test
  def test_start_span
    assert_equal OpenTracing::Span::NOOP_INSTANCE, OpenTracing::Tracer.new.start_span("operation_name")
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

  private

  def assert_warn(msg, &block)
    original_stderr = $stderr
    begin
      str = StringIO.new
      $stderr = str
      block.call
      assert_equal msg, str.string
    ensure
      $stderr = original_stderr
    end
  end

  def tracer
    OpenTracing::Tracer.new
  end
end
