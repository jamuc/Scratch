require 'minitest/autorun'

class Person
end

def add_checked_attribute(klass, attribute, &validation)
    klass.class_eval do
        define_method attribute do 
            instance_variable_get "@#{attribute}"
        end
    
        define_method "#{attribute}=" do |new_age|
            raise 'Invalid attribute' unless new_age
            raise 'Invalid attribute' unless validation.call(new_age)
            instance_variable_set("@#{attribute}", new_age)
        end
    end
end

describe Person do 
    
    before do
        add_checked_attribute(Person, :age) {|v| v >= 18}
        @bob = Person.new
    end

    it 'refuses invalid values' do 
        lambda {@bob.age = 17}.must_raise RuntimeError
    end

    it 'refuses nil values' do 
       lambda {@bob.age = nil}.must_raise RuntimeError 
    end

    it 'refuses false values' do
        lambda {@bob.age = false}.must_raise RuntimeError
    end

    it 'accepts valid values' do 
        @bob.age = 20
        @bob.age.must_equal 20
    end
end
