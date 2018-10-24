# Changelog

## 0.4.3

* Specify versions for development dependencies ([#40](https://github.com/opentracing/opentracing-ruby/pull/40))

## 0.4.2

* Update opentracing.io links and scheme on README ([#38](https://github.com/opentracing/opentracing-ruby/pull/38))

* Add active_span method to Tracer ([#34](https://github.com/opentracing/opentracing-ruby/pull/34))

## 0.4.1

* Add active_span convenience method to OpenTracing module ([#30](https://github.com/opentracing/opentracing-ruby/pull/30))
* Fix global tracer delegators ([#28](https://github.com/opentracing/opentracing-ruby/pull/28))
* Add Rubocop ([#29](https://github.com/opentracing/opentracing-ruby/pull/27))
* Update license from MIT => Apache 2.0 ([#26](https://github.com/opentracing/opentracing-ruby/pull/26))

## 0.4.0

* The tracer now implements the OpenTracing Scope API for in-process scope propagation([#21](https://github.com/opentracing/opentracing-ruby/pull/21))
* Adds a `log_kv` method and deprecates `log` for consistency with other language implementations. See [#22](https://github.com/opentracing/opentracing-ruby/pull/23).

## 0.3.2

* Addressing Ruby style issues ([#14](https://github.com/opentracing/opentracing-ruby/pull/14))
* Default to the no-op tracer ([#17](https://github.com/opentracing/opentracing-ruby/pull/17))
* Fixing serialization example in README ([#18](https://github.com/opentracing/opentracing-ruby/pull/18))
* Removing bundler development version requirement
