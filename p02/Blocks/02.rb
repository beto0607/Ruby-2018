

def procesar_hash(h={}, b)
  Hash[ h.map { |e| [e[1], b.call( e[0])]  }]
end



hash ={ 'clave' => 1, :otra_clave => 'valor' }
p procesar_hash(hash, ->(x) { x.to_s.upcase })
