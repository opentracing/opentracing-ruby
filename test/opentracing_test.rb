require 'test_helper'
require 'net/http'

class OpenTracingTest < Minitest::Test
  def setup
    @original_global_tracer = OpenTracing.global_tracer
  end

  def teardown
    OpenTracing.global_tracer = @original_global_tracer
  end

  def test_global_tracer_is_nil_by_default
    assert_nil OpenTracing.global_tracer
  end

  def test_global_tracer_start_span
    tracer = Minitest::Mock.new
    OpenTracing.global_tracer = tracer

    span = Minitest::Mock.new
    tracer.expect(:start_span, span, ["span"])
    OpenTracing.start_span("span")
  end

  def test_global_tracer_inject
    tracer = Minitest::Mock.new
    OpenTracing.global_tracer = tracer

    span_context = Minitest::Mock.new
    format = Minitest::Mock.new
    carrier = Minitest::Mock.new

    tracer.expect(:inject, nil, [span_context, format, carrier])
    OpenTracing.inject(span_context, format, carrier)
  end

  def test_global_tracer_extract
    tracer = Minitest::Mock.new
    OpenTracing.global_tracer = tracer

    format = Minitest::Mock.new
    carrier = Minitest::Mock.new

    tracer.expect(:extract, nil, [format, carrier])
    OpenTracing.extract(format, carrier)
  end
end
