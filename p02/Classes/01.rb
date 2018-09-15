class Vehiculo
  attr_accessor :tiene_llave
  def initialize
    @nombre = 'Vehiculo'
    @tiene_llave = false
  end

  def arrancar
    if puede_arrancar?
      puts "#{@nombre} arranco"
    else
      puts "#{@nombre} no arranco"
    end
  end

  def puede_arrancar?
    tiene_llave
  end

end

class Auto < Vehiculo
  attr_accessor :freno_de_mano, :cambio

  def initialize
    super()
    @freno_de_mano = true
    @cambio = 'primera'
    @nombre = 'Auto'
  end

  def puede_arrancar?
    super && freno_de_mano == false && cambio == 'punto_muerto'
  end
end

class Moto < Vehiculo
  attr_accessor :pateada
  def initialize
    super()
    @pateada = false
    @nombre = 'Moto'
  end
  def puede_arrancar?
    @pateada
  end
  def patear
    @pateada = true
  end
end

class Lancha < Vehiculo
  def initialize
    super()
    @nombre = 'Lancha'
  end
end




class Taller
  def probar(objecto)
    objecto.arrancar
  end
end


taller = Taller.new

auto = Auto.new
auto.freno_de_mano = false
auto.tiene_llave = true
auto.cambio = 'punto_muerto'
taller.probar(auto)

lancha = Lancha.new
lancha.tiene_llave = true
taller.probar(lancha)

moto = Moto.new
moto.patear
taller.probar(moto)



__END__

Se utiliza herencia y polimorfismo
