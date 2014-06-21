# My implementation of the OpenStruct behaviour.
# A small forray into meta-programming.
class MyStruct

    def initialize(opts={})
        @values = opts
    end

    def method_missing(method_name, *args, &block)
        setter_reg = /(\w+)\s{0,1}=$/
        match = method_name.to_s.match(setter_reg)
        @values[match[1].to_sym] = args.first if match
        
        @values[method_name]
    end
end
