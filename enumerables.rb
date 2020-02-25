module Enumerable
  def my_each
    size = count - 1
    counter = 0
    items = to_a
    while counter <= size
      if is_a? Range
        items.length >= 0 && yield(items[counter])
      else
        yield(self[counter])
      end
      counter += 1
    end
    self
  end
end

p 'When an array is iterated with my_each'
[4, 5, 6].my_each do |x|
  p x
end

puts '<<< >>>>'

p 'When a Range is iterated with my_each'
(1..4).my_each do |x|
  p x
end

# { "a": 2, "re": 7 }.my_each do |x, y|
#   p x.to_s + ":" + y.to_s
# end
