require 'test_helper'
require 'net/http'

class OpenTracingTest < Minitest::Test
  def test_global_tracer
    assert_nil OpenTracing.global_tracer
    tracer = Minitest::Mock.new
    OpenTracing.global_tracer = tracer

    span = Minitest::Mock.new
    tracer.expect(:start_span, span, ["span"])
    span = OpenTracing.start_span("span")
  end

  def test_inject_text_map
    context = OpenTracing::SpanContext.new()
    carrier = {}
    OpenTracing.inject(context, OpenTracing::FORMAT_TEXT_MAP, carrier)
  end

  def test_inject_binary
    OpenTracing.inject(nil, OpenTracing::FORMAT_BINARY, nil)
  end

  def test_inject_rack
    context = OpenTracing::SpanContext.new()
    OpenTracing.inject(context, OpenTracing::FORMAT_RACK, {})
  end

  def test_invalid_inject_format
    assert_warn "Unknown inject format\n" do
      OpenTracing.inject(nil, 9999, nil)
    end
  end

  def test_extract_text_map
    tracer = Minitest::Mock.new
    span = OpenTracing.extract("operation_name", OpenTracing::FORMAT_TEXT_MAP, {}, tracer)
  end

  def test_extract_binary
    OpenTracing.extract(nil, OpenTracing::FORMAT_BINARY, nil, nil)
  end

  def test_extract_rack
    tracer = Minitest::Mock.new
    OpenTracing.extract("operation_name", OpenTracing::FORMAT_RACK, {}, tracer)
  end

  def test_extract_unknown
    assert_warn "Unknown extract format\n" do
      OpenTracing.extract(nil, 999, nil, nil)
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
end
