module Reverso
  def di_tcejbo
    self.object_id.to_s.reverse!
  end
  def ssalc
    self.class.to_s.reverse!
  end
end

class TestReverso
  include Reverso
end

t = TestReverso.new

puts t.di_tcejbo
puts t.ssalc
