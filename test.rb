require './enumerables'

test_arr2 = [2, nil, 6, 8]

puts '<<<< Teasting my_each >>>>'

p "When an array #{test_arr2} is iterated with my_each"
test_arr2.my_each do |x|
  p x
end

rangy1 = 1..4
p "When a Range #{rangy1} is iterated with my_each"
rangy1.my_each do |x|
  p x
end

hashy = { 1 => 2, 2 => 7 }
p "When a Hash #{hashy} is iterated with my_each"
hashy.my_each do |left, right|
  p left => right
end

test_arr = [3, 5, 9, 0, 4]
puts "<<<< Testing #{test_arr} with my_each_with_index >>>>"
test_arr.my_each_with_index do |x, y|
  puts "#{y}: #{x}"
end

puts '<<<< Testing my_select >>>>'
test_arr.my_select do |req|
  p req.odd?
end

puts '<<<< Testing my_all >>>>'
[nil, true, 99].my_all? do |d|
  p d.is_a? Numeric
end

%w[ant bear cat].my_all? do |word|
  p word.length >= 3
end

p %w[ant bear cat].my_all?(/t/) #=> false
p [1, 2i, 3.14].my_all?(Numeric) #=> true
p [nil, true, 99].my_all? #=> false
p [].my_all?

puts '<<<< Testing my_any >>>>'
# p %w[ant bear ca].my_any? { |word| word.length <= 2 }
p [1, '2', 3].my_any?(Integer) # true
p %w[efe obi aji].my_any?(Integer) # false
p %w[ant bat cat].my_any?(/g/) # false
p [1, 2, '4'].my_any? # true
%w[ant bear ca].my_any? do |ds|
  p ds.length <= 2
end

puts '<<<< Testing my_none >>>>'
# p %w[ant bear cat].my_none? { |word| word.length <= 2 }
p [1, 2, 3].none?(Integer) # false
p [1, 3, 3].my_none?(String) # true
p %w[efe obi aji].my_none?(Integer) # true
p %w[ant bat cat].my_none?(/b/) # false
p [1, 2, '4'].my_none? # false
%w[ant bear ca].my_none? do |ds|
  p ds.length <= 2
end

puts '<<<< Testing my_count >>>>'
%w[ant bear ca].my_count { |el| el.length > 2 }
rangy_b = 1..8
p rangy_b.my_count(3)
p [3, 4, 3, 6, 'o'].my_count
[5, 7, 8, 25].my_count do |d|
  p d > 10
end

puts '<<<< Testing my_map >>>>'
test_arr3 = [5, 7, 8, 9]
p "#{test_arr3} using my_map multiplied by itself gives #{test_arr3.my_map { |h| h * h }}"

puts '<<<< Testing my_inject >>>>'
p [5, 6, 7, 8].my_inject(:+)
p [5, 6, 7, 8].my_inject(5, :+) { |sum, n| sum + n }
p [5, 6, 7, 8].my_inject(1) { |sum, n| sum + n }
rany = 1..3
p rany.my_inject(:*)
