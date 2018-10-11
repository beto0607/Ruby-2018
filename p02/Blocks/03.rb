
def excepciones(*args, &b)
  begin
    b.call *args
  rescue RuntimeError
    puts "Algo salió mal..."
    return :rt
  rescue NoMethodError
    puts "No encontré un método:", $!.message
    return :nm
  rescue
    puts "¡No sé qué hacer!"
    raise $!
  else
    return :ok
  end
end


p(excepciones(2,3,4) do |*a|
  a.each {|i| raise RuntimeError}
end)
