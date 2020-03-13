
#!!!! For now file main.rb only for testing other classes.
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'station'
require_relative 'route'

sev = Station.new ('Sevastopol')
mos = Station.new ('Moskov')
sim = Station.new ('Simferopol')



ms = Route.new mos, sev

ms.add_way_station (sim)


t1 = PassengerTrain.new 't1_pass', 10
t2 = CargoTrain.new 't2_cargo', 5
t3 = PassengerTrain.new 't3_pass', 15



t1.set_current_route (ms)
t2.set_current_route (ms)
t3.set_current_route (ms)

puts 'TEST current station'


puts t1.current_station
puts '>>1 sim'
t1.go_next_station

puts t1.current_station
puts '>>2 sev'
t1.go_next_station

puts t1.current_station
puts '>>2 sev again'
t1.go_next_station

puts t1.current_station
puts '1<< sim'
t1.go_previous_station

puts t1.current_station
puts '0<< mos'
t1.go_previous_station

puts t1.current_station
puts '0<< mos again'
t1.go_previous_station

puts t1.current_station

p1 = PassengerTrain.new('typkkkkPass', 10)
