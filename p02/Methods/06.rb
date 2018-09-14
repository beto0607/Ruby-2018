# Tira un dado virtual de 6 caras
def tirar_dado
  rand 1..6
end
# Mueve la ficha de un jugador tantos casilleros como indique el dado en un tablero virtual de 40 posiciones.
# Si no se recibe la cantidad de casilleros, aprovecho el valor por defecto para ese parámetro para evitar tener que
# llamar a #tirar_dado dentro del cuerpo del método.
def mover_ficha (fichas, jugador, casilleros = tirar_dado)
  fichas[jugador] += casilleros
  if fichas[jugador] > 40
    puts "Ganó #{jugador}!!"
    true
  else
    puts "#{jugador} ahora está en el casillero #{fichas[jugador]}"
    fichas[jugador]
  end
end

posiciones = { azul: 0, rojo: 0, verde: 0 }

finalizado = false
until finalizado
  ['azul', 'rojo', 'verde'].shuffle.each do  |jugador|
    finalizado = mover_ficha ( posiciones, jugador )
  end
  
end


#Linea 9: fichas['azul'] devuelve nil, porque debería ser :azul
#Linea 15: devuelve la posicion del jugador, lo cual rompería el bucle en el primer llamado, debería devolver false
#Linea 23: en vez de usar el array, se puede usar posiciones.keys
#Linea 24: finalizado se modifica 1 vez por jugador, sin guardar si el anterior jugador ya gano. Es decir, el juego terminaría cuando el ultimo jugador del do, gane
#Linea 24: quitar el espacio entre mover_ficha y ()
