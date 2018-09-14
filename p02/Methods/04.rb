def longitud(*params)
  params.each do |item|
    puts "#{item.to_s} --> #{item.to_s.length}"
  end
end


longitud(9, Time.now, 'Hola', {un: 'hash'}, :ruby)
