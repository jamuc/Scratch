require 'minitest/autorun'

class Person
end

def add_checked_attribute(klass, attribute)
end

describe Person do 
    
    before do
        add_checked_attribute(Person, :age)
        @bob = Person.new
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
