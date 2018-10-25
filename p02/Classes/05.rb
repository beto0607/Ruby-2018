
class GenericFactory
  def self.create(**args)
    new(**args)
  end
  def initialize(**args)
    raise NotImplementedError
  end
end

class FirstChild < GenericFactory
  attr_reader :var_1
  def initialize(**args)
    @var_1 = args[:var_1]
  end

end


a = FirstChild.create({:var_1=>"af"})
p a
puts a.var_1
