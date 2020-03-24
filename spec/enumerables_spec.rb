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
    it('Should return an array when numbers within the hash are looped over') do
      custom_hash = []
      test_hash.my_each do |hash|
        custom_hash << hash
      end
      generic_hash = []
      test_hash.each do |hash|
        generic_hash << hash
      end
      expect(custom_hash).to eq(generic_hash)
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
      custom_range = []
      test_range.my_each do |range|
        custom_range << range
      end
      generic_range = []
      test_range.each do |range|
        generic_range << range
      end
      expect(custom_range).to eq(generic_range)
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
      custom_select = select_arr.my_select { |s| s > 2 }
      generic_select = select_arr.select { |t| t > 2 }
      expect(custom_select).to eq(generic_select)
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

  describe '#my_count' do
    it 'Should return number of items in an array' do
      custom_count = all_arr.my_count
      generic_count = all_arr.count
      expect(custom_count).to eq(generic_count)
    end
    it 'Should return number of items in an array in addition to the number given as PARAMETER' do
      custom_count = all_arr.my_count(2)
      generic_count = all_arr.count(2)
      expect(custom_count).to eq(generic_count)
    end
  end

  describe('#my_map') do
    it('Should return the Array to_enum when NO BLOCK_GIVEN') do
      actual = test_arr.my_map
      expect(actual.to_a).to eq(test_arr)
    end
    it('Should return same value as the Generic Ruby map method when BLOCK_GIVEN') do
      custom_map = all_arr.my_map { |s| s > 4 }
      generic_map = all_arr.map { |t| t > 4 }
      expect(custom_map).to eq(generic_map)
    end
  end
  describe('my_inject') do
    it('Should return same value as the Generic Ruby inject method when given a SUM symbol') do
      custom_inject = all_arr.my_inject(:+)
      generic_inject = all_arr.inject(:+)
      expect(custom_inject).to eq(generic_inject)
    end

    it('Should return same value as the Generic Ruby inject method when given a MULTIPLICATION symbol') do
      custom_inject = all_arr.my_inject(:*)
      generic_inject = all_arr.inject(:*)
      expect(custom_inject).to eq(generic_inject)
    end

    it('Should return same value as the Generic Ruby inject method when given a MODULUS symbol') do
      custom_inject = all_arr.my_inject(:%)
      generic_inject = all_arr.inject(:%)
      expect(custom_inject).to eq(generic_inject)
    end

    it('Should return same value as the Generic Ruby inject method when BLOCK_GIVEN & with TWO PARAMETERS') do
      custom_inject = all_arr.my_inject(5, :+) { |sum, n| sum + n }
      generic_inject = all_arr.inject(5, :+) { |sum, n| sum + n }
      expect(custom_inject).to eq(generic_inject)
    end

    it('Should return same value as the Generic Ruby inject method when BLOCK_GIVEN & with ONE PARAMETERS') do
      custom_inject = all_arr.my_inject(1) { |sum, n| sum + n }
      generic_inject = all_arr.inject(1) { |sum, n| sum + n }
      expect(custom_inject).to eq(generic_inject)
    end

    let(:inject_range) { 1..9 }
    it('Should return same value as the Generic Ruby inject method when tested with a Range') do
      custom_inject = inject_range.my_inject(:+)
      generic_inject = inject_range.inject(:+)
      expect(custom_inject).to eq(generic_inject)
    end
  end
end
