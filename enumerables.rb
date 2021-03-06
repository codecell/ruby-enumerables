module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    size = count - 1
    counter = 0
    items = to_a
    while counter <= size
      if is_a? Range
        items.length >= 0 && yield(items[counter])
      elsif is_a? Hash
        yield(items[counter])
      elsif !block_given?
        return self
      else
        yield(self[counter])
      end
      counter += 1
    end
    self
  end

  def my_each_with_index()
    return to_enum(:my_each_with_index) unless block_given?

    counter = 0
    size = length - 1

    while counter <= size
      yield(self[counter], counter)
      counter += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    required = []

    my_each do |r|
      required.push(r) if yield(r)
    end
    required
  end

  def my_all?(*param)
    track_negative = 0
    size = count - 1
    counter = 0

    while counter <= size && !self[counter + 1].nil?
      if param[0].class == Class
        track_negative += self[counter].class == self[counter + 1].class ? 0 : 1
        counter += 1
      elsif param[0].class == Regexp
        track_negative += self[counter].to_s.match(param[0]).nil? == self[counter + 1].to_s.match(param[0]).nil? ? 0 : 1
        counter += 1
      elsif block_given?
        my_each do |p|
          track_negative += yield(p) ? 0 : 1
          counter += 1
        end
      elsif !param[0].nil? && !block_given?
        my_each do |ds|
          track_negative += ds == param[0] ? 0 : 1
          counter += 1
        end
      else
        my_each do |d|
          track_negative += d ? 0 : 1
          counter += 1
        end
      end
    end
    !track_negative.positive?
  end

  def my_any?(*param)
    yes = 0
    size = count - 1
    counter = 0

    while counter <= size
      if param[0].class == Class
        yes += self[counter].class == param[0] ? 1 : 0
        counter += 1
      elsif param[0].class == Regexp
        yes += self[counter].to_s.match(param[0]).nil? ? 0 : 1
        counter += 1
      elsif block_given? && param[0].nil?
        my_each do |sth|
          yes += yield(sth) ? 1 : 0
          counter += 1
        end
      elsif !param[0].nil? && !block_given?
        my_each do |d|
          yes += d == param[0] ? 1 : 0
          counter += 1
        end
      else
        my_each do |sth|
          yes += sth ? 1 : 0
          counter += 1
        end
      end
      yes
    end
    yes.positive?
  end

  def my_none?(*param)
    satisfies = 0
    size = count - 1
    counter = 0

    while counter <= size
      if param[0].class == Class
        satisfies += self[counter].class == param[0] ? 1 : 0
        counter += 1
      elsif param[0].class == Regexp
        satisfies += self[counter].to_s.match(param[0]).nil? ? 0 : 1
        counter += 1
      elsif block_given? && param[0].nil?
        my_each do |s|
          satisfies += yield(s) ? 1 : 0
          counter += 1
        end
      elsif !block_given? && !param[0].nil?
        my_each do |t|
          satisfies += t == param[0] ? 1 : 0
          counter += 1
        end
      else
        my_each do |t|
          satisfies += t ? 1 : 0
          counter += 1
        end
      end
    end
    !satisfies.positive?
  end

  def my_count(*param)
    counter = 0
    return to_a.length if param.empty? && !block_given?

    if param && !block_given?
      my_each do |d|
        param[0] == d ? counter += 1 : false
      end
    elsif block_given?
      my_each do |el|
        yield(el) ? counter += 1 : false
      end
    end
    counter
  end

  def my_map(proc_map = nil)
    array = []
    if block_given? && proc_map.nil?
      my_each { |i| array.push(yield(i)) }
      array
    elsif !proc_map.nil? && !block_given?
      my_each do |i|
        array.push(proc_map.call(i))
      end
      array
    else
      to_enum(:my_map)
    end
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
      elsif !argu.empty? && (argu[0].is_a? Integer) && (argu.length == 2)
        memo = argu[0]
        my_each do |d|
          memo = d ? memo.send(argu[1], d) : false
          counter += 1
        end
        memo
      elsif argu.class.is_a? Range
        memo += self[counter]
        counter += 1
        memo
      elsif block_given?
        my_each do |n|
          memo = memo.nil? ? n : yield(memo, n)
          counter += 1
        end
      end
    end
    memo
  end
end
