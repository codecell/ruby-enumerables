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

  def my_select
    required = []
    my_each do |r|
      required.push(yield(r))
    end
    required
  end

  def my_all?
    track_negative = 0
    my_each do |t|
      yield(t) == true ? true : track_negative += 1
    end
    !track_negative.positive?
  end

  def my_any?
    yes = 0
    my_each do |y|
      yield(y) == true ? yes += 1 : false
    end
    yes.positive?
  end

  def my_none?
    satisfies = 0
    my_each do |chek|
      yield(chek) == false ? true : satisfies += 1
    end
    satisfies.positive? ? false : true
  end

  def my_count
    counter = 0
    my_each do |el|
      yield(el) ? counter += 1 : false
    end
    counter
  end

  def my_map
    cont_arr = []
    my_each do |cont|
      cont_arr.push(yield(cont)) if yield(cont)
    end
    cont_arr
  end
end

# p 'When an array is iterated with my_each'
# [4, 5, 6].my_each do |x|
#   p x
# end

# puts '<<<< >>>>'

# p 'When a Range is iterated with my_each'
# (1..4).my_each do |x|
#   p x
# end

# puts '<<<< >>>>'

# p 'When a Hash is iterated with my_each'
# { "a": 2, "re": 7 }.my_each do |left, right|
#   p left.to_s + ': ' + right.to_s
# end

# puts '<<<< Testing my_each_with_index >>>>'
# test_arr = [3, 5, 9, 0, 4]
# test_arr.my_each_with_index do |x, y|
#   puts "#{y}: #{x}"
# end

# puts '<<<< Testing my_select >>>>'
# test_arr.my_select do |req|
#   p req.odd?
# end

# test_arr2 = [2, nil, 6, 8]

# puts '<<<< Testing my_all >>>>'
# p [nil, true, 99].my_all? { |elem| elem.is_a? Numeric }

# p %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# p %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# p %w[ant bear cat].my_all?(/t/)                      #=> false
# p [1, 2i, 3.14].my_all?(Numeric)                       #=> true
# p [nil, true, 99].my_all?                              #=> false
# p [].my_all?
# [1, 2i, 3.14].my_all? do |x|
#   p x.class == Numeric
# end

# puts '<<<< Testing my_any >>>>'
# # p %w[ant bear ca].my_any? { |word| word.length <= 2 }
# %w[ant bear ca].my_any? do |ds|
#   p ds.length <= 2
# end

# puts '<<<< Testing my_none >>>>'
# p %w[ant bear cat].my_none? { |word| word.length <= 2 }
# %w[ant bear ca].my_none? do |ds|
#   p ds.length <= 2
# end

# puts '<<<< Testing my_count >>>>'
# # p %w[ant bear ca].my_count { |el| el.length > 2 }
# %w[ant bear ca].my_count do |ds|
#   p ds.length >= 2
# end

# p %w[ant bear ca].my_count('ca')

# puts '<<<< Testing my_map >>>>'
# p [5, 7, 8, 9].my_map { |h| h * h }
