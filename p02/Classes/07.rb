
module OppositeModule
  def opposite
    not self
  end
end

class TrueClass
  include OppositeModule
end

class FalseClass
  include OppositeModule
end

puts false.opposite
puts true.opposite

puts true.opposite.opposite
