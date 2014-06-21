# My implementation of the OpenStruct behaviour.
# A small forray into meta-programming.
class MyStruct

    def initialize(opts={})
        @values = Hash.new
        opts.each do |key, value|
            generate_accessors(key, value)
        end
    end

    def method_missing(method_name, *args, &block)
        setter_reg = /(\w+)\s{0,1}=$/
        getter_reg = /(\w+)$/
        
        match = method_name.to_s.match(setter_reg)
        if match
            method_name = match[1].to_sym
        else
            match = method_name.to_s.match(getter_reg)
            super unless match
        end

        generate_accessors(method_name, args.first)
        self.send(method_name)
    end

private

    def generate_accessors(method_name, arg)
        setter_method_name = (method_name.to_s + "=").to_sym
        
        self.class.send :define_method, setter_method_name do |value|
            @values[method_name] = value
        end
        self.class.send :define_method, method_name do
            @values[method_name]
        end
        self.send(setter_method_name, arg)
    end
end
