

fibonacci = Enumerator.new do |caller|
  i1, i2 = 1,1
  loop do
    caller.yield i1
    i1, i2 = i2, i2+i1
  end
end


10.times{puts fibonacci.next}
