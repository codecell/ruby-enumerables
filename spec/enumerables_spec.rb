require './enumerables.rb'

RSpec.describe Enumerable do
  let(:test_arr) { [2, nil, 6, 8] }
  let(:all_arr) { [2, 10, 6, 8, 4] }

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
      custom_selects = select_arr.my_select { |s| s > 2 }
      generic_selects = select_arr.select { |t| t > 2 }
      expect(custom_selects).to eq(generic_selects)
    end
  end
  describe('#my_all?') do
    it('Should return same value as the Generic Ruby all method when BLOCK_GIVEN') do
      custom_all = all_arr.my_all? { |s| s > 4 }
      generic_all = all_arr.all? { |t| t > 4 }
      expect(custom_all).to eq(generic_all)
    end
  end
  describe('#my_any?') do
    it('Should return same value as the Generic Ruby any method when BLOCK_GIVEN') do
      custom_any = all_arr.my_any? { |s| s > 4 }
      generic_any = all_arr.any? { |t| t > 4 }
      expect(custom_any).to eq(generic_any)
    end
    it('Should return same value as the Generic Ruby any method when given a PARAMETER') do
      custom_any = all_arr.my_any?(1)
      generic_any = all_arr.any?(1)
      expect(custom_any).to eq(generic_any)
    end
    it('Should return same value as the Generic Ruby any method when given CLASS value') do
      custom_any = all_arr.my_any?(Integer)
      generic_any = all_arr.any?(Integer)
      expect(custom_any).to eq(generic_any)
    end
    let(:any_string_arr) { %w[ant bear cat] }
    it('Should return same value as the Generic Ruby any method when given a REGEXP') do
      custom_any = any_string_arr.my_any?(/t/)
      generic_any = any_string_arr.any?(/t/)
      expect(custom_any).to eq(generic_any)
    end
    let(:any_values) { [nil, true, 99] }
    it('Should return same value as the Generic Ruby any method when given RANDOM values without PARAMETER') do
      custom_any = any_values.my_any?
      generic_any = any_values.any?
      expect(custom_any).to eq(generic_any)
    end
  end
  describe('#my_none?') do
    it('Should return same value as the Generic Ruby any method when BLOCK_GIVEN') do
      custom_none = all_arr.my_none? { |s| s > 4 }
      generic_none = all_arr.none? { |t| t > 4 }
      expect(custom_none).to eq(generic_none)
    end
    it('Should return same value as the Generic Ruby none method when given a PARAMETER') do
      custom_none = all_arr.my_none?(1)
      generic_none = all_arr.none?(1)
      expect(custom_none).to eq(generic_none)
    end
    it('Should return same value as the Generic Ruby none method when given CLASS value') do
      custom_none = all_arr.my_none?(Integer)
      generic_none = all_arr.none?(Integer)
      expect(custom_none).to eq(generic_none)
    end
    let(:none_string_arr) { %w[ant bear cat] }
    it('Should return same value as the Generic Ruby none method when given a REGEXP') do
      custom_none = none_string_arr.my_none?(/t/)
      generic_none = none_string_arr.none?(/t/)
      expect(custom_none).to eq(generic_none)
    end
    let(:none_values) { [nil, true, 99] }
    it('Should return same value as the Generic Ruby none method when given RANDOM values without PARAMETER') do
      custom_none = none_values.my_none?
      generic_none = none_values.none?
      expect(custom_none).to eq(generic_none)
    end
  end
end
