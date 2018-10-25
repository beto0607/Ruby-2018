
require 'matrix'

class Image
  attr_accessor :data, :size

  def initialize(data = nil, size = 1024)
    self.size = size
    self.data = (data || Matrix.build(size) { Math::PI }).lazy
  end

  def header_bytes
    Matrix.rows([data.first(size)])
  end

  # Distintos filtros de imágenes:

  def filter_a
    Image.new data.map { |e| e ** 1.2 }
  end

  def filter_b
    Image.new data.map { |e| e ** 1.4 }
  end

  def filter_c
    Image.new data.map { |e| e ** 1.8 }
  end

  def filter_d
    Image.new data.map { |e| e ** 2 }
  end

  def filter_e
    Image.new data.map { |e| e ** 2.2 }
  end

  def filter_f
    Image.new data.map { |e| e ** 2.4 }
  end

  #- Fin de filtros

  def all_filters
    ('a'..'f').inject(self) do |pipe, type|
      pipe.public_send "filter_#{type}"
    end
  end
end

time = Time.now
image = Image.new(nil, 1024 * 4)
puts "initialize tooks: "+ (Time.now - time).to_s

time = Time.now
image.filter_a.filter_c.filter_e
puts "primero tooks:"+(Time.now - time).to_s

time = Time.now
image.filter_a.filter_c.filter_e.header_bytes
puts "segundo tooks:"+ (Time.now - time).to_s
