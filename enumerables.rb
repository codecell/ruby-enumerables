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

  def my_inject(*argu)
    counter = 0
    block_nd_string_arg = (argu[0].is_a? String) && block_given?
    memo = (argu.length == 1 && (block_nd_string_arg || !(argu[0].is_a? Symbol))) || argu.length == 2 ? argu[0] : nil

    while counter < count
      if !argu.empty? && ((argu[0].is_a? Symbol) || (argu[0].is_a? String))
        my_each do |m|
          memo = memo.nil? ? m : memo.send(argu[0], m)
          counter += 1
        end
        memo
      elsif argu.class.is_a? Range
        memo += self[counter]
        counter += 1
        memo
      else
        my_each do |n|
          memo = memo.nil? ? n : yield(memo, n)
          counter += 1
        end
      end
    end
    memo
  end
end
