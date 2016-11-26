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
end
