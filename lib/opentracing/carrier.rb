module OpenTracing
  # Carriers are used for inject and extract operations. A carrier should be a
  # Hash or hash-like object. At a minimum, it should implement `[]`, `[]=`, and
  # `each` shown here.
  class Carrier
    # [] retrieves a value by the given key
    # @param key [String] key to retrieve the value
    # @return [String] the desired value
    def [](key); end

    # []= sets the value for the given key
    # @param key [String] key to set
    # @param value [String] value to set
    def []=(key, value); end

    # each iterates over every key-value pair in the carrier
    # @yield [key, value]
    # @yieldparam key [String] the key of the tuple
    # @yieldparam value [String] the value of the tuple
    def each(&block); end
  end
end
