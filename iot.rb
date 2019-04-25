require  'restforce'
require  'redis'

salesforce     = Restforce.new
redis          = Redis.new
serial_number  = ENV['SERIAL_NUMBER'].to_s
activations    = redis.get(serial_number).to_i + Random.rand(12)
is_error       = [true, false]
error_codes    = ['500', '800', '991']

if is_error.sample == true
  error_code   = error_codes.sample
else
  error_code   = '000'
end

puts "PRIOR VALUE ==> Key: #{serial_number} | Value: " + redis.get(serial_number)

# set activations number in redis and update salesforce with information
redis.set(serial_number, activations)
salesforce.create('Manufacturing_Robot_Event__e', number_of_activations__c: activations, serial_no__c: serial_number, error_code__c: error_code)

puts "NEW VALUE   ==> Key: #{serial_number} | Value: #{activations}"
puts 'Platform Event Processed!'
