# Changelog

## 0.4.0

* The tracer now implements the OpenTracing Scope API for in-process scope propagation([#21](https://github.com/opentracing/opentracing-ruby/pull/21))
* Adds a `log_kv` method and deprecates `log` for consistency with other language implementations. See [#22](https://github.com/opentracing/opentracing-ruby/pull/23).

## 0.3.2

* Addressing Ruby style issues ([#14](https://github.com/opentracing/opentracing-ruby/pull/14))
* Default to the no-op tracer ([#17](https://github.com/opentracing/opentracing-ruby/pull/17))
* Fixing serialization example in README ([#18](https://github.com/opentracing/opentracing-ruby/pull/18))
* Removing bundler development version requirement
