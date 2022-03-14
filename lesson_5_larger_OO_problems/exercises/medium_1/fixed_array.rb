# A fixed-length array is an array that always has a fixed number of elements. Write a class that implements a fixed-length array, and provides the necessary methods to support the following code:

class FixedArray
  attr_reader :size

  def initialize(size)
    @size = size
    @array = [nil] * size
  end

  def to_a
    @array
  end

  def [](index)
    return @array[index] if in_range?(index)
    raise IndexError
  end

  def in_range?(num)
    (-size...size).include?(num)
  end

  def []=(index, value)
    if in_range?(index)
      @array[index] = value
    else
      raise IndexError
    end
  end

  def to_s
    @array.to_s
    # [nil] * size
  end
end

fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end