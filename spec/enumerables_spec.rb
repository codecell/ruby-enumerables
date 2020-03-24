require './enumerables.rb'

RSpec.describe Enumerable do 
  describe('my_each') do
    let(:test_arr) { [2, nil, 6, 8] }
    it('Should loop over an array and return each element') do
      actual = test_arr.my_each
      expect(actual.to_a).to eq(test_arr)
    end

    let(:test_hash) { { 1 => 1, 2 => 2, 3 => 3 } }
    it('Should loop over an array and return an 2D array') do
      actual = test_hash.my_each
      expect(actual.to_h).to eq(test_hash)
    end

    let(:test_range) { 0..5 }
    it 'Should return same value when my_each and each are looped over the array' do
      arr_one = []
      test_range.my_each do |range|
        arr_one << range
      end

      arr_two = []
      test_range.each do |range|
        arr_two << range
      end
      expect(arr_one).to eq(arr_two)
    end
    it 'Should return an array when numbers within the range are looped over' do
      arr_one = []
      test_range.my_each do |range|
        arr_one << range
      end

      arr_two = []
      test_range.each do |range|
        arr_two << range
      end
      expect(arr_one).to eq(arr_two)
    end
  end
  describe('#my_each_with_index') do
    let(:test_arr) {[2, 4, 5, 9, 6]}
    it 'Should return key value pairs of a hash when looped over' do
      arr_one = test_arr.my_each_with_index do |v, k|
        p "#{k}: #{v}"
      end
      
      arr_two = test_arr.each_with_index do |v, k|
        p "#{k}: #{v}"
      end
      expect(arr_one).to eq(arr_two)
    end
  end
end