require './enumerables.rb'

RSpec.describe Enumerable do 
  let(:test_arr) { [2, nil, 6, 8] }
  describe('my_each') do
    it('Should return the Array to_enum when NO BLOCK_GIVEN') do
      actual = test_arr.my_each
      expect(actual.to_a).to eq(test_arr)
    end

    let(:test_hash) { { 1 => 1, 2 => 2, 3 => 3 } }
    it('Should return the Hash to_enum when NO BLOCK_GIVEN') do
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

  describe('#my_select') do
    it('Should return self to_enum when NO BLOCK_GIVEN') do
      actual = test_arr.my_select
      expect(actual.to_a).to eq(test_arr)
    end

    let(:select_arr) { [2, 10, 6, 8, 4] }
    it('Should return same value as the Generic Ruby select method when BLOCK_GIVEN') do 
      custom_selects = select_arr.my_select{ |s| s > 2 }      
      generic_selects = select_arr.select{ |t| t > 2 }

      expect(custom_selects).to eq(generic_selects)
    end
  end

  let(:all_arr) { [2, 10, 6, 8, 4] }
  describe('#my_all') do 
    it('Should return same value as the Generic Ruby all method when BLOCK_GIVEN') do 
      custom_alls = all_arr.my_all?{ |s| s > 4 }      
      generic_alls = all_arr.all?{ |t| t > 4 }

      expect(custom_alls).to eq(generic_alls)
    end
  end


end