require './enumerables.rb'

RSpec.describe Enumerable do 
  let(:test_arr) { [2, nil, 6, 8] }

  describe('my_each') do
    it('Should loop over an array and return each element') do
      actual = test_arr.my_each
      expect(actual.to_a).to eq(test_arr)
    end
  end
end