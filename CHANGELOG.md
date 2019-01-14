# Changelog

## 0.5.0

* Tracer#start_span now accepts an optional block. When passed a block, it returns the block's return value, otherwise it returns the newly-created span ([#45](https://github.com/opentracing/opentracing-ruby/pull/45)). See [Issue #13](https://github.com/opentracing/opentracing-ruby/issues/13).

* When passed an optional block, Tracer#start_active_span returns the block's return value, otherwise it returns the newly-created scope. This is a change in behavior as it previously returned a scope in both cases([#45](https://github.com/opentracing/opentracing-ruby/pull/45)). See [Issue #41](https://github.com/opentracing/opentracing-ruby/issues/41).

* Improved documentation for `log` and `log_kv` methods ([#44](https://github.com/opentracing/opentracing-ruby/pull/44))

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
