def cuanto_falta? (time = Time.new(Time.now.year,Time.now.month,Time.now.day,23,59,59))
  (time - Time.now) / 60
end

puts cuanto_falta? Time.new(2018, 12, 31, 23, 59, 59)
puts cuanto_falta?
