require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'station'
require_relative 'route'

# !!!!!!!!!!!!!!Sooner, Take every puts from other classes into Menu class!!!!!!!!!!!!
class Menu
  def initialize
  end

  def start
    puts 'Hello!'
    menu
  end

  private

  def menu
    puts 'Enter: 1, to create station, train, carriage or route for train.'
    puts 'Enter: 2, to manipulate with created objects.'
    puts 'Enter: 3, to look at list of created objects.'
    puts 'Enter: exit, to exit.'
    case input
    when '1'
      menu_1
    when '2'
      menu_2
    when '3'
      menu_3
    when 'exit'
      puts 'Good buy!'
      exit(0)
    else
      puts 'Invalid input!'
      menu
    end
  end

  def menu_1
    puts 'If you want to create:'
    puts 'Enter: 1, to create station.'
    puts 'Enter: 2, to create train.'
    puts 'Enter: 3 to create route.'
    puts 'Enter: 4 to create carriage.'
    puts 'Enter: 5, go to the main menu.'
    puts 'Enter: exit, to exit.'
    case input
    when '1'
      menu_create_station
    when '2'
      menu_create_train
    when '3'
      menu_create_route
    when '4'
      menu_create_carriage
    when '5'
      menu
    when 'exit'
      exit(0)
    else
      puts 'Invalid input!'
    end
    puts 'Choose what do you want next:'
    menu_1
  end

  def menu_2
    puts 'Enter: 1, to manipulate with created routes.'
    puts 'Enter: 2, to manipulate with created trains.'
    puts 'Enter: 3, to manipulate with created carriages.'
    puts 'Enter: 4, to go to the main menu.'
    puts 'Enter: exit, to exit.'
    case input
    when '1'
      menu_manipulate_routes
    when '2', '3'
      menu_choose_train
      menu_manipulate_trains
    when '4'
      menu
    when 'exit'
      exit(0)
    else
      puts 'Invalid input!'
    end
    menu_2
  end

  def menu_3
    puts 'Enter: 1, to look at created stations.'
    puts 'Enter: 2, to look at created routes.'
    puts 'Enter: 3, to look at created trains.'
    puts 'Enter: 4, to look at trains on station.'
    puts 'Enter: 5, to look at created carriages.'
    puts 'Enter: 6, to go to the main menu.'
    puts 'Enter: exit, to exit.'
    case input
    when '1'
      stations_list
    when '2'
      routes_list
    when '3'
      trains_list
    when '4'
      show_trains_on_current_station
    when '5'
      passenger_carriages_list
      cargo_carriages_list
    when '6'
      menu
    when 'exit'
      exit(0)
    else
      puts 'Invalid input!'
    end
    menu_3
  end

  def input
    @input = gets.chomp.downcase
  end

  def menu_create_station

    puts "Enter: station's name."
    input
    @stations ||= Array.new
    @stations << Station.new(@input)
    puts "Station #{@input} was created."
  end

  def menu_create_route
    if @stations.size < 2
      puts 'Firstly create at least 2 stations.'
      menu_create_station
    else
      stations_list
      puts 'Enter: sequence number of start station.'
      input
      input until valid_input?(@stations)
      start_station = @stations[@input.to_i - 1]
      puts 'Enter: sequence number of end station.'
      input until valid_input?(@stations) && @stations[@input.to_i - 1] != start_station
      end_station = @stations[@input.to_i - 1]
      @routes ||= Array.new
      @routes << Route.new(start_station, end_station)
      puts 'New route was created.'
    end
  end

  def menu_create_train
    puts 'Enter: 1, to create passenger train'
    puts 'Enter: 2, to create cargo train'
    puts 'Enter: 3, to go previous menu.'
    puts 'Enter: 4, to go to the main menu.'
    puts 'Enter: exit, to exit.'
    case input
    when '1'
    puts "Enter: train's number:"
    @trains ||= Array.new
    @trains << PassengerTrain.new(input)
    puts "Passenger train #{@input} was created."
    when '2'
    puts "Enter: train's number:"
    @trains ||= Array.new
    @trains << CargoTrain.new(input)
    puts "Cargo train #{@input} was created."
    when '3'
    menu_1
    when '4'
      menu
    when 'exit'
      exit(0)
    else
      puts 'Wrong input!'
    end
  end

  def menu_create_carriage
    puts 'Enter: 1, to create passenger carriage.'
    puts 'Enter: 2, to create cargo carriage.'
    puts 'Enter: 3, to go previous menu.'
    puts 'Enter: exit to exit.'
    case(input)
    when '1'
      puts 'Enter: passenger carriage number.'
      @carriages ||= Array.new
      @carriages << PassengerCarriage.new(input)
      puts "Passenger carriage #{@input} was created."
    when '2'
      puts 'Enter: cargo carriage number.'
      @carriages ||= Array.new
      @carriages << CargoCarriage.new(input)
      puts "Cargo carriage #{@input} was created."
    when '3'
      menu_1
    when 'exit'
      exit(0)
    else
      puts 'Invalid input!'
    end
  end

  def menu_manipulate_routes
    puts 'Enter: 1, to add station to the route.'
    puts 'Enter: 2, to delete station from the route.'
    puts 'Enter: 3, go to the train menu.'
    puts 'Enter: 4, go to the main menu.'
    puts 'Enter: 5, go to previous menu.'
    puts 'Enter: exit, to exit.'
    case input
    when '1'
      menu_add_station
    when '2'
      menu_delete_station
    when '3'
      menu_manipulate_trains
    when '4'
      menu
    when '5'
      menu_2
    when 'exit'
      exit(0)
    else
      puts 'Invalid input!'
    end
    menu_manipulate_routes
  end

  def menu_manipulate_trains
    puts 'Enter: 1, to set a route to a train.'
    puts 'Enter: 2, to add a carriage to a train.'
    puts 'Enter: 3, to delete a carriage from a train.'
    puts 'Enter: 4, to set a speed to a train.'
    puts 'Enter: 5, to go next station.'
    puts 'Enter: 6, to go previous station.'
    puts 'Enter: 7, to stop a train.'
    puts 'Enter: 8, go to the main menu.'
    puts 'Enter: 9, go to previous menu.'
    puts 'Enter: exit, to exit.'
    case input
    when '1'
      menu_set_route
    when '2'
      menu_add_carriage
    when '3'
      train_carriages_list
      menu_delete_carriage
    when '4'
      menu_set_speed
    when '5'
      menu_set_route  until @train.current_route
      menu_go_next_station
    when '6'
      menu_set_route until @train.current_route
      menu_go_previous_station
    when '7'
      @train.speed = 0
      puts "Speed of the train #{@train.number} now is 0 km/h. "
    when '8'
      menu
    when '9'
      menu_2
    when 'exit'
      exit(0)
    else
      puts 'Invalid input!'
    end
    menu_manipulate_trains
  end

  def valid_input?(arr)
    @input.to_i > 0 && @input.to_i <= arr.size
  end

  # Later if possible to give argument as method, than refactor with current method methods such as 'objects_list'
  # def objects_list(objects, method)
  # objects.each { |object| puts "#{objects.index(object) + 1}: #{object.method}" }
  # end

  def stations_list
    puts 'Stations:'
    @stations.each { |station| puts "#{@stations.index(station) + 1}: #{station.name}" }
  end

  def routes_list
    puts 'Routes:'
    @routes.each { |route| puts "#{@routes.index(route) + 1}: #{route.to_s}" }
  end

  def trains_list
    puts 'Trains:'
    @trains.each { |train| puts "#{train.number} - #{train.type}" }
  end

  def pass_trains_list
    puts 'Passenger trains:'
    pass_trains = @trains.select { |train| train.type == 'pass' }
    pass_trains.each { |train| puts "#{train.number}" }
  end

  def cargo_trains_list
    puts 'Cargo trains:'
    cargo_trains = @trains.select { |train| train.type == 'cargo' }
    cargo_trains.each { |train| puts "#{train.number}" }
  end

  def passenger_carriages_list
    puts 'Passenger carriages:'
    pass_carriages = @carriages.select { |carriage| carriage.type == 'pass'}
    pass_carriages.each { |carriage| puts "#{carriage.number}" }
  end

  def cargo_carriages_list
    puts 'Cargo carriages:'
    cargo_carriages = @carriages.select { |carriage| carriage.type == 'cargo'}
    cargo_carriages.each { |carriage| puts "#{carriage.number}" }
  end

  def train_carriages_list
    puts "Carriages of the train #{@train.number}"
    @train.carriages.each { |carriage| puts "#{@train.carriages.index(carriage) + 1}: #{carriage.number}"}
  end

  def route_stations_list
    puts "Stations of the current route:"
    @routes[@input.to_i - 1].each { |station| puts "#{@routes[@input.to_i - 1].index(station) + 1}: #{station.name}"}
  end

  def show_trains_on_current_station
    if !@stations
      puts 'Firstly create some stations'
      menu_create_station
    else
      stations_list
      puts 'Enter sequence number of station'
      input until valid_input?(@stations)
      station_sequence_number = @input.to_i
      puts "On current station #{@stations[station_sequence_number - 1].name}:"
      if !@stations[station_sequence_number - 1].trains
        puts '0 trains.'
      else
        puts "Passenger trains:"
        puts @stations[station_sequence_number - 1].show_trains_on_station_by_type('pass').each.number
        puts "Cargo trains on station:"
        puts @stations[station_sequence_number - 1].show_trains_on_station_by_type('cargo').each.number
      end
    end
  end

  def menu_add_station
    puts 'For adding station:'
    if !@routes
      puts 'Firstly create some route.'
      menu_create_route
    else
      puts 'Choose route:'
      routes_list
      input
      input until valid_input?(@routes)
      manipulated_route_index = @input.to_i - 1
      puts 'Choose station:'
      stations_list
      input
      input until valid_input?(@stations)
      manipulated_station_index = @input.to_i - 1
      @routes[manipulated_route_index].add_way_station(@stations[manipulated_station_index]) until @routes[manipulated_route_index].stations.include?(@stations[manipulated_station_index])
      puts "Station #{@stations[@input.to_i - 1].name} added to the chosen route."
    end
  end

  def menu_delete_station
    if !@routes
      puts 'Firstly create some route.'
      menu_create_route
    else
      puts 'To delete station:'
      puts 'Choose route:'
      routes_list
      input
      input until valid_input?(@routes)
      manipulated_route_index = @input.to_i - 1
      if @routes[manipulated_route_index].stations.size == 2
        puts 'Route should have at least 2 stations.'
        puts "You can't delete anymore station."
      else
        puts 'Choose station:'
        route_stations_list
        input
        input until valid_input?(@stations)
        @routes[manipulated_route_index].delete_way_station(@stations[@input.to_i - 1]) while @routes.include?(@stations[@input.to_i])
        puts "Station #{@stations[@input.to_i - 1].name} deleted from the chosen route."
      end
    end
  end

  def menu_choose_train
    puts 'Enter: 1, to choose passenger train.'
    puts 'Enter: 2, to choose cargo train.'
    puts 'Enter: 3, to go to the main menu.'
    puts 'Enter: exit, to exit'
    case input
    when '1'
      pass_trains_list
      choose_train('pass')
    when '2'
      cargo_trains_list
      choose_train('cargo')
    when '3'
      menu
    when 'exit'
      exit(0)
    else
      puts 'Invalid input!'
      menu_choose_train
    end
  end

  def choose_train(type)
    if !@trains
      puts 'Firstly create some train!'
      menu_create_train
      @train = @trains[0]
      puts "Train #{@trains[0]} was chosen."
    elsif @trains.select { |train| train.type == type }.empty?
      puts "Firstly create some #{type} train."
      menu_create_train
      choose_train(type)
    else
      puts 'Enter train number.'
      input
      input until Train.find(@input)
      @train = Train.find(@input)
      puts "Train #{@train.number} was chosen."
    end
  end

  def menu_set_route
    routes_list
    if !@routes
      puts 'Firstly, create some route.'
      menu_create_route
    else
      puts 'Enter sequence number of route.'
      input
      input until valid_input?(@routes)
      @train.set_current_route(@routes[@input.to_i - 1])
      puts "The route #{@routes[@input.to_i - 1].to_s} was set to the train #{@train.number}"
    end
  end

  def menu_add_carriage
    puts 'Enter: 1, to add passenger carriage.'
    puts 'Enter: 2, to add cargo carriage.'
    puts 'Enter: 3, go to the main menu.'
    puts 'Enter: 4, go to previous menu.'
    puts 'Enter: exit, to exit.'
    case input
    when '1'
      passenger_carriages_list
      choose_carriage('pass')
      add_chosen_carriage
    when '2'
      cargo_carriages_list
      choose_carriage('cargo')
      add_chosen_carriage
    when '3'
      menu
    when '4'
      menu_manipulate_trains
    when 'exit'
    else
      puts 'Invalid input!'
    end
  end

  def choose_carriage(type)
    if !@carriages
      puts 'Firstly create some carriage.'
      menu_create_carriage
      @carriage = carriages[0]
    elsif @carriages.select { |carriage| carriage.type == type}.empty?
      puts "Firstly create some #{type} carriage"
      menu_create_carriage
      @carriage = @carriages.find { |carriage| carriage.type == type }
      puts "Carriage #{@carriage.number} was chosen."
    else
      puts 'Enter carriage number:'
      input
      input until carriage_by_number(@input)
      @carriage = carriage_by_number(@input)
      puts "Carriage #{@carriage.number} was chosen."
    end
  end

  def carriage_by_number(number)
    @carriages.find { |carriage| carriage.number == number }
  end

  def add_chosen_carriage
    if @carriage.type != @train.type
    puts "Invalid type of carriage!"
    puts "Choose another carriage or train."
    menu_add_carriage
    elsif @train && @carriage
      @train.add_carriage(@carriage)
      puts "Carriage #{@carriage.number} added to the train #{@train.number}."
    elsif !@train
      puts 'Firstly choose some train.'
      menu_choose_train
      add_chosen_carriage
    elsif !@carriage
      puts 'Firstly choose some carriage.'
      menu_add_carriage

    elsif @speed > 0
      puts 'Firstly stop the train.'
    else
      puts 'Invalid type of carriage.'
    end
  end

  def menu_delete_carriage
    choose_carriage(@train.carriages)
    @train.delete_carriage(@carriage)
  end
  def menu_set_speed
    puts 'Enter number of speed from 0 to 100 in km/h to set to the train.'
    input
    input until ((@input.to_i >= 0) && (@input.to_i <= 100))
    @train.speed = @input.to_i
    puts "The train #{@train.number} go now #{@train.speed} km/h."
  end

  def menu_go_next_station
    @train.go_next_station
    puts "Train #{@train.number} now on the #{@train.current_station.name} station."
  end

  def menu_go_previous_station
    @train.go_previous_station
    puts "Train #{@train.number} now on the #{@train.current_station.name} station."
  end
end

Menu.new.start