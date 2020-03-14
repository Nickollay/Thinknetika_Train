
#!!!! For now file main.rb only for testing other classes.
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'station'
require_relative 'route'

class Menu

  def menu
    puts 'Enter: 1, if you want to create station, train, carriage or route for train.'
    puts 'Enter: 2, if you want to manipulate with created objects.'
    puts 'Enter: 3, if you want to look at list of created objects'
    puts 'Enter: stop, if you want to exit.'
  end

  
  def menu_1

  end

  def menu_2

  end

  def menu_3

  end



  private
  def input
    @input = gets.chomp.downcase
  end

  # add message later
  def stop
    abort
  end

  def choice
    case input
    when '1'
      menu_1
    when '2'
      menu_2
    when '3'
      menu_3
    when 'stop'
      stop
    else
      menu
    end
  end

  # puts "Enter 'add station'
  # Создавать станции
  #- Создавать поезда
  #- Создавать маршруты и управлять станциями в нем (добавлять, удалять)
  #- Назначать маршрут поезду
  #- Добавлять вагоны к поезду
  #- Отцеплять вагоны от поезда
  #- Перемещать поезд по маршруту вперед и назад
  #- Просматривать список станций и список поездов на станции
end




=begin
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

c1 = CargoCarriage.new
p1 = PassengerCarriage.new

t1.add_carriage(c1)
t1.add_carriage(p1)

t1.delete_carriage(p1)=end
