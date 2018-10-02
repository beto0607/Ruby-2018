module GenericFactory #se modifico clas a module

  def create(**args)#se borro self.
    new(**args)
  end
  def initialize(**args)
    raise NotImplementedError
  end
end

class FirstChild # se borro < GenericFactory
  extend GenericFactory #se agrego el include
  attr_reader :var_1
  def initialize(**args)
    @var_1 = args[:var_1]
  end

end

a = FirstChild.create({:var_1=>"af"})
p a
puts a.var_1
