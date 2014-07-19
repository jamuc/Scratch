# Re-define plus method so that the plus operation 
# returns result plus 1
require 'minitest/autorun'

class Fixnum
    alias_method :old_plus, :+

    def +(a_fixnum)
        result = old_plus(a_fixnum)
        result.old_plus(1)
    end
end

describe Fixnum do 
    it 'adds 1 to the plus operation' do
        (1 + 1).must_equal 3
    end
end
