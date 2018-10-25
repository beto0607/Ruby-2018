
VALUE = 'global'

module A
  VALUE = 'A'

  class B
    VALUE = 'B'

    def self.value
      VALUE
    end

    def value
      'iB'
    end
  end

  def self.value
    VALUE
  end
end

class C
  class D
    VALUE = 'D'

    def self.value
      VALUE
    end
  end

  module E
    def self.value
      VALUE
    end
  end

  def self.value
    VALUE
  end
end

class F < C
  VALUE = 'F'
end

puts A.value
puts A::B.value
puts C::D.value
puts C::E.value
puts F.value


puts A::value
puts A.new.value
puts B.value
puts C::D.value
puts C.value
puts F.superclass.value
=begin
Preguntas         --> Respuesta --> Resultado de ejecución
puts A.value      --> 'A'       --> 'A'
puts A::B.value   --> 'B'       --> 'B'
puts C::D.value   --> 'D'       --> 'D'
puts C::E.value   --> 'global'  --> 'global'
puts F.value      --> 'F'       --> 'global'
=end

=begin
Preguntas                 --> Respuesta                           --> Resultado de ejecución
puts A::value             --> sin error                           --> 'A'
puts A.new.value          --> con error, value es metodo de clase --> 'undefined new'
puts B.value              --> no se conoce B                      --> 'unintilialized constatn B'
puts C::D.value           --> sin error                           --> 'D'
puts C.value              --> sin error                           --> 'global'
puts F.superclass.value   --> sin error                           --> 'global'

=end
