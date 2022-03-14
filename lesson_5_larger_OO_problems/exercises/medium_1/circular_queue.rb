require 'pry'
class CircularQueue
  def initialize(size)
    @size = size
    @queue = Array.new(size)
    @next_pos = 0
    @oldest_pos = 0
  end

  def enqueue(object)
    if @next_pos == @oldest_pos && !(@queue[@oldest_pos].nil?)
      @oldest_pos = ((@oldest_pos + 1) % @size)
    end
    @queue[@next_pos] = object
    @next_pos = ((@next_pos + 1) % @size)
  end

  def dequeue
    value = @queue[@oldest_pos]
    @queue[@oldest_pos] = nil
    @oldest_pos = ((@oldest_pos + 1) % @size) unless value.nil?
    value
  end
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
