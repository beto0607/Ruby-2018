module Countable

  def Countable.included(mod)
    @last_method = nil
  end

  def counters
    @counters ||= {}
  end

  def count_invocations_of(sym)
    counters[sym] = 0
    sym_old = (sym.to_s + "_old").to_sym

    Countable::ºdefine_method(sym_old) do |*arguments|
      counters[sym] += 1
      puts "define_method"
      self.send(sym, *arguments)
    end
    Countable::alias_method  sym, sym_old

  end

  def invoked?(sym)
    puts counters[sym] > 0
  end

  def invoked(sym)
    puts counters[sym]
  end

end


class Greeter
  include Countable

  def initialize
    count_invocations_of :hi
  end

  def hi
    puts 'hi!'
  end

  def bye
    puts 'bye!'
  end
end

a = Greeter.new

a.invoked? :hi
a.hi
a.invoked? :hi

p a.counters
