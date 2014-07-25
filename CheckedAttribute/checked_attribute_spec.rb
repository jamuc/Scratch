require 'minitest/autorun'

module CheckedAttributes

    def self.included(klass)
        klass.extend CheckedAttributes
    end

    def attr_checked(attribute, &validation)
         define_method attribute do 
            instance_variable_get "@#{attribute}"
        end

         define_method "#{attribute}=" do |new_age|
            raise 'Invalid attribute' unless new_age
            raise 'Invalid attribute' unless yield(new_age)
            instance_variable_set("@#{attribute}", new_age)
        end
    end
end

class Person
    include CheckedAttributes
    attr_checked :age do |v|
        v >= 18
    end
end

describe Person do 
    
    before do
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
