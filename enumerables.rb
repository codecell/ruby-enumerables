module Enumerable
  def my_each
    size = count - 1
    counter = 0
    items = to_a
    while counter <= size
      if is_a? Range
        items.length >= 0 && yield(items[counter])
      elsif is_a? Hash
        yield(items[counter][0], items[counter][1])
      else
        yield(self[counter])
      end
      counter += 1
    end
    self
  end

  def my_each_with_index()
    counter = 0
    size = length - 1
    while counter <= size
      yield(self[counter], counter)
      counter += 1
    end
    self
  end
end

# p 'When an array is iterated with my_each'
# [4, 5, 6].my_each do |x|
#   p x
# end

# puts '<<< >>>>'

# p 'When a Range is iterated with my_each'
# (1..4).my_each do |x|
#   p x
# end

# puts '<<< >>>>'

# p 'When a Hash is iterated with my_each'
# { "a": 2, "re": 7 }.my_each do |left, right|
#   p left.to_s + ': ' + right.to_s
# end

puts '<<< Testing my_each_with_index >>>>'
test_arr = [3, 5, 9, 0]
test_arr.my_each_with_index do |x, y|
  puts "#{y}: #{x}"
end
