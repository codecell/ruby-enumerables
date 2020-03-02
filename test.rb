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

hashy = { "a": 2, "re": 7 }
p "When a Hash #{hashy} is iterated with my_each"
hashy.my_each do |left, right|
  p left.to_s + ': ' + right.to_s
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
p [nil, true, 99].my_all? { |elem| elem.is_a? Numeric }

p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# p %w[ant bear cat].my_all?(/t/)                      #=> false
# p [1, 2i, 3.14].my_all?(Numeric)                       #=> true
# p [nil, true, 99].my_all?                              #=> false
p [].my_all?

puts '<<<< Testing my_any >>>>'
p %w[ant bear ca].my_any? { |word| word.length <= 2 }
%w[ant bear ca].my_any? do |ds|
  p ds.length <= 2
end

puts '<<<< Testing my_none >>>>'
p %w[ant bear cat].my_none? { |word| word.length <= 2 }
%w[ant bear ca].my_none? do |ds|
  p ds.length <= 2
end

puts '<<<< Testing my_count >>>>'
p %w[ant bear ca].my_count { |el| el.length > 2 }
# %w[ant bear ca].my_count do |ds|
#   p ds.length >= 2
# end

puts '<<<< Testing my_map >>>>'
test_arr3 = [5, 7, 8, 9]
p "#{test_arr3} using my_map multiplied by itself gives #{test_arr3.my_map { |h| h * h }}"

puts '<<<< Testing my_inject >>>>'
p [5, 6, 7, 8].my_inject(:+)
p [5, 6, 7, 8].my_inject(5, :+) { |sum, n| sum + n }
p [5, 6, 7].my_inject(:*) { |sum, n| sum + n }
p [5, 6, 7, 8].my_inject(1) { |sum, n| sum + n }
# rany = 1..3
# p rany.my_inject(:*)
# memo always retains the initializer