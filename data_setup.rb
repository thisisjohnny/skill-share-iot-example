require  'redis'

redis               = Redis.new
serial_number       = ENV['SERIAL_NUMBER'].to_s
default_activations = ENV['DEFAULT_ACTIVATIONS'].to_i

puts "PRIOR VALUE ==> Key: #{serial_number} | Value: " + redis.get(serial_number)

redis.set(serial_number, default_activations)

puts "NEW VALUE   ==> Key: #{serial_number} | Value: #{default_activations}"
puts "Processed Redis key/value setup!"
