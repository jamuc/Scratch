require "minitest/autorun"
require './my_struct.rb'

describe MyStruct do 
	it "allows dynamically generating getter/setter at runtime" do
		my = MyStruct.new
		my.name.must_be_nil "There was no name set, so nil should be returned"
	    
        my.name = "Howard"
        my.name.must_equal "Howard"

        my = MyStruct.new age: 42
        my.age.must_equal 42
	end
end
