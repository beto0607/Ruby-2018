def opcion_1
    a = [1, nil, 3, nil, 5, nil, 7, nil, 9, nil]
    b = 3
    c = a.map do |x|
        x * b
    end
    puts c.inspect
rescue
    0
end
  
def opcion_2
    c = begin
        a = [1, nil, 3, nil, 5, nil, 7, nil, 9, nil]
        b = 3
        a.map do |x|
            x * b
        end
    rescue
        0
    end
    puts c.inspect
end
  
def opcion_3
    a = [1, nil, 3, nil, 5, nil, 7, nil, 9, nil]
    b = 3
    c = a.map { |x| x * b } rescue 0
    puts c.inspect
end
  
def opcion_4
    a = [1, nil, 3, nil, 5, nil, 7, nil, 9, nil]
    b = 3
    c = a.map { |x| x * b rescue 0 }
    puts c.inspect
end
puts "opcion_1"
opcion_1
puts "opcion_2"
opcion_2
puts "opcion_3"
opcion_3
puts "opcion_4"
opcion_4
=begin
opcion_1 => la instrucción puts no se ejecuta
opcion_2 => la instrucion puts se ejecuta y muesta 0
opcion_3 => lo mismo que opcion_2
opcion_4 => puts imprime el arreglo c con 0 en lugar de nil y los valores correspondientes en las otra ubicaciones


=end