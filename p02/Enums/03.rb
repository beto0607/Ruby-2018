class Array
  def randomly &b
    if block_given? then
      self.sample(self.length).each do |e|
        b.call e
      end
    else
      Enumerator.new do |caller|
        self.sample(self.length).each do |e|
          caller.yield e
        end
      end
    end
  end
end

[1,2,3].randomly {|a| puts a}
puts "----"
r = [1,2,3].randomly
puts r.next
puts r.next
puts r.next
