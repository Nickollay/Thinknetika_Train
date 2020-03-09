
#!!!! For now file main.rb only for testing other classes.
require_relative 'train'
require_relative 'station'
require_relative 'route'

sev = Station.new ('Sevastopol')
mos = Station.new ('Moskov')
sim = Station.new ('Simferopol')

p mos
p sev
p sim

ms = Route.new mos, sev
p ms
ms.add_way_station (sim)
p ms

t1 = Train.new 't1_pass', 'pass', 10
t2 = Train.new 't2_cargo', 'cargo', 5
t3 = Train.new 't3_pass', 'pass', 15

p t1
p t2

t1.set_current_route (ms)
t2.set_current_route (ms)
t3.set_current_route (ms)

p t1.current_route.route[0].name
p t1.current_route.route[1]
p t1.current_route.route[2]

#p t1.current_station.trains_on_station.each
puts mos.show_trains
p mos.show_trains_on_station_by_type'pass'
mos.send_train(t3)
p mos.show_trains_on_station_by_type'pass'

p t1.current_station
p t1.next_station
p t1.previous_station

puts 'test'
t1.go_next_station
p t1.current_station
p t1.next_station
p t1.previous_station
p mos.show_trains_on_station_by_type'pass'
p mos.show_trains_on_station_by_type'cargo'

#t1.go_next_station
t1.go_next_station
p t1.current_station
p t1.next_station
p t1.previous_station

puts 'test: go_previous_station'
t1.go_previous_station
t1.go_previous_station
t1.go_previous_station
p t1.current_station
p t1.next_station
p t1.previous_station


