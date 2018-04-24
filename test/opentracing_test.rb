require 'test_helper'
require 'net/http'

class OpenTracingTest < Minitest::Test
  def setup
    @original_global_tracer = OpenTracing.global_tracer
  end

  def teardown
    OpenTracing.global_tracer = @original_global_tracer
  end

  def test_global_tracer_is_not_nil_by_default
    assert OpenTracing.global_tracer
  end

  def test_global_tracer_scope_manager
    tracer = Minitest::Mock.new
    OpenTracing.global_tracer = tracer

    scope_manager = Minitest::Mock.new
    tracer.expect(:scope_manager, scope_manager)
    OpenTracing.scope_manager

    tracer.verify
  end

  def test_global_tracer_start_active_span
    tracer = Minitest::Mock.new
    OpenTracing.global_tracer = tracer

    scope = Minitest::Mock.new
    tracer.expect(:start_active_span, scope, ['span'])
    OpenTracing.start_active_span('span')

    tracer.verify
  end

  def test_global_tracer_start_span
    tracer = Minitest::Mock.new
    OpenTracing.global_tracer = tracer

    span = Minitest::Mock.new
    tracer.expect(:start_span, span, ['span'])
    OpenTracing.start_span('span')

    tracer.verify
  end

  def test_global_tracer_inject
    tracer = Minitest::Mock.new
    OpenTracing.global_tracer = tracer

    span_context = Minitest::Mock.new
    format = Minitest::Mock.new
    carrier = Minitest::Mock.new

    tracer.expect(:inject, nil, [span_context, format, carrier])
    OpenTracing.inject(span_context, format, carrier)

    tracer.verify
  end

  def test_global_tracer_extract
    tracer = Minitest::Mock.new
    OpenTracing.global_tracer = tracer

    format = Minitest::Mock.new
    carrier = Minitest::Mock.new

    tracer.expect(:extract, nil, [format, carrier])
    OpenTracing.extract(format, carrier)

    tracer.verify
  end

  def test_global_tracer_active_span
    tracer = Minitest::Mock.new
    OpenTracing.global_tracer = tracer

    scope_manager = Minitest::Mock.new
    scope = Minitest::Mock.new
    span = OpenTracing::Span::NOOP_INSTANCE

    tracer.expect(:scope_manager, scope_manager)
    scope_manager.expect(:active, scope)
    scope.expect(:span, span)

    assert_equal span, OpenTracing.active_span
    [tracer, scope_manager, scope].map(&:verify)
  end
end
