require 'simplecov'
require 'simplecov-console'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::Console,
]
SimpleCov.minimum_coverage 100
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'opentracing'

require 'minitest/autorun'

def assert_warn(msg, &block)
  original_stderr = $stderr
  begin
    str = StringIO.new
    $stderr = str
    yield
    assert_equal msg, str.string
  ensure
    $stderr = original_stderr
  end
end
