require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'station'
require_relative 'route'

class Menu
  def initialize
    @created_stations = []
    @created_pass_trains = []
    @created_cargo_trains = []
    @created_routes = []
    @created_pass_carriages = []
    @created_cargo_carriages = []
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
    puts 'Enter: 5, to go to the main menu.'
    puts 'Enter: exit, to exit.'
    case input
    when '1'
      created_stations_list
    when '2'
      created_routes_list
    when '3'
      created_pass_trains_list
      created_cargo_trains_list
    when '4'
      show_trains_on_current_station
    when '5'
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
    @created_stations << Station.new(@input)
    puts "Station #{@input} was created."
  end

  def menu_create_route
    if @created_stations.size < 2
      puts 'Firstly create at least 2 stations.'
      menu_create_station
    else
      created_stations_list
      puts 'Enter: sequence number of start station.'
      input
      input until valid_input?(@created_stations)
      start_station = @created_stations[@input.to_i - 1]
      puts 'Enter: sequence number of end station.'
      input until valid_input?(@created_stations) && @created_stations[@input.to_i - 1] != start_station
      end_station = @created_stations[@input.to_i - 1]
      @created_routes << Route.new(start_station, end_station)
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
    @created_pass_trains << PassengerTrain.new(input)
    puts "Passenger train #{@input} was created."
    when '2'
    puts "Enter: train's number:"
    @created_cargo_trains << CargoTrain.new(input)
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
      @created_pass_carriages << PassengerCarriage.new(input)
      puts "Passenger carriage #{@input} was created."
    when '2'
      puts 'Enter: cargo carriage number.'
      @created_cargo_carriages << CargoCarriage.new(input)
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
      menu_set_route  while @train_to_manipulate.current_route == []
      menu_go_next_station
    when '6'
      menu_set_route while @train_to_manipulate.current_route == []
      menu_go_previous_station
    when '7'
      @train_to_manipulate.speed = 0
      puts "Speed of the train #{@train_to_manipulate.train_number} now is 0 km/h. "
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

  # Later if possible to give argument as method, than refactor with current method methods such as 'created_objects_list'
  # def created_objects_list(created_objects, method)
  # created_objects.each { |object| puts "#{created_objects.index(object) + 1}: #{object.method}" }
  # end

  def created_stations_list
    puts 'Stations:'
    @created_stations.each { |station| puts "#{@created_stations.index(station) + 1}: #{station.name}" }
  end

  def created_routes_list
    puts 'Routes:'
    @created_routes.each { |route| puts "#{@created_routes.index(route) + 1}: #{route.to_s}" }
  end

  def created_pass_trains_list
    puts 'Passenger trains:'
    @created_pass_trains.each { |train| puts "#{@created_pass_trains.index(train) + 1}: #{train.train_number}" }
  end

  def created_cargo_trains_list
    puts 'Cargo trains:'
    @created_cargo_trains.each { |train| puts "#{@created_cargo_trains.index(train) + 1}: #{train.train_number}" }
  end

  def created_passenger_carriages_list
    puts 'Passenger carriages:'
    @created_pass_carriages.each { |carriage| puts "#{@created_pass_carriages.index(carriage) + 1}: #{carriage.carriage_number}"}
  end

  def created_cargo_carriages_list
    puts 'Cargo carriages:'
    @created_cargo_carriages.each { |carriage| puts "#{@created_cargo_carriages.index(carriage) + 1}: #{carriage.carriage_number}"}
  end

  def train_carriages_list
    puts "Carriages of the train #{@train_to_manipulate.train_number}"
    @train_to_manipulate.carriages.each { |carriage| puts "#{@train_to_manipulate.carriages.index(carriage) + 1}: #{carriage.carriage_number}"}
  end

  def created_route_stations_list
    puts "Stations of the current route:"
    @created_routes[@input.to_i - 1].each { |station| puts "#{@created_routes[@input.to_i - 1].index(station) + 1}: #{station.name}"}
  end

  def show_trains_on_current_station
    if @created_stations.empty?
      puts 'Firstly create some stations'
      menu_create_station
    else
    created_stations_list
    puts 'Enter sequence number of station'
    input until valid_input?(@created_stations)
    station_sequence_number = @input.to_i
    puts "On current station #{@created_stations[station_sequence_number - 1].name}:"
    if @created_stations[station_sequence_number - 1].trains.empty?
      puts '0 trains.'
    else
      puts "Passenger trains:"
      puts @created_stations[station_sequence_number - 1].show_trains_on_station_by_type('pass').each.train_number
      puts "Cargo trains on station:"
      puts @created_stations[station_sequence_number - 1].show_trains_on_station_by_type('cargo').each.train_number
    end
    end
  end

  def menu_add_station
    puts 'For adding station:'
    if @created_routes.empty?
      puts 'Firstly create some route.'
      menu_create_route
    else
      puts 'Choose route:'
      created_routes_list
      input
      input until valid_input?(@created_routes)
      manipulated_route_index = @input.to_i - 1
      puts 'Choose station:'
      created_stations_list
      input
      input until valid_input?(@created_stations)
      manipulated_station_index = @input.to_i - 1
      @created_routes[manipulated_route_index].add_way_station(@created_stations[manipulated_station_index]) until @created_routes[manipulated_route_index].stations.include?(@created_stations[manipulated_station_index])
      puts "Station #{@created_stations[@input.to_i - 1].name} added to the chosen route."
    end
  end

  def menu_delete_station
    if @created_routes.empty?
      puts 'Firstly create some route.'
      menu_create_route
    else
      puts 'To delete station:'
      puts 'Choose route:'
      created_routes_list
      input
      input until valid_input?(@created_routes)
      manipulated_route_index = @input.to_i - 1
      if @created_routes[manipulated_route_index].stations.size == 2
        puts 'Route should have at least 2 stations.'
        puts "You can't delete anymore station."
      else
        puts 'Choose station:'
        created_route_stations_list
        input
        input until valid_input?(@created_stations)
        @created_routes[manipulated_route_index].delete_way_station(@created_stations[@input.to_i - 1]) while @created_routes.include?(@created_stations[@input.to_i])
        puts "Station #{@created_stations[@input.to_i - 1].name} deleted from the chosen route."
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
      created_pass_trains_list
      choose_train(@created_pass_trains)
    when '2'
      created_cargo_carriages_list
      choose_train(@created_cargo_trains)
    when '3'
      menu
    when 'exit'
      exit(0)
    else
      puts 'Invalid input!'
      menu_choose_train
    end
  end

  def choose_train(created_trains_by_type)
    if created_trains_by_type.empty?
      puts 'Firstly create some train!'
      menu_create_train
    else
      puts 'Enter sequence number of train.'
      input
      input until valid_input?(created_trains_by_type)
      @train_to_manipulate = created_trains_by_type[@input.to_i - 1]
      puts "Train #{@train_to_manipulate.train_number} was chosen."

    end
  end

  def menu_set_route
    created_routes_list
    if @created_routes.empty?
      puts 'Firstly, create some route.'
      menu_create_route
    else
      puts 'Enter sequence number of route.'
      input
      input until valid_input?(@created_routes)
      @train_to_manipulate.set_current_route(@created_routes[@input.to_i - 1])
      puts "The route #{@created_routes[@input.to_i - 1].to_s} was set to the train #{@train_to_manipulate.train_number}"
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
      created_passenger_carriages_list
      choose_carriage(@created_pass_carriages)
      add_chosen_carriage
    when '2'
      created_cargo_carriages_list
      choose_carriage(@created_cargo_carriages)
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

  def choose_carriage(carriages_by_type)
    if carriages_by_type.empty?
      puts 'Firstly create some carriage.'
      menu_create_carriage
      @carriage_to_manipulate = carriages_by_type[0]
    else
      puts 'Enter sequence number of carriage'
      input
      input until valid_input?(carriages_by_type)
      @carriage_to_manipulate = carriages_by_type[@input.to_i - 1]
      puts "Carriage #{@carriage_to_manipulate.carriage_number} was chosen."
    end

    def add_chosen_carriage
      @train_to_manipulate.add_carriage(@carriage_to_manipulate)
    end
  end

  def menu_delete_carriage
    choose_carriage(@train_to_manipulate.carriages)
    @train_to_manipulate.delete_carriage(@carriage_to_manipulate)
  end
  def menu_set_speed
    puts 'Enter number of speed from 0 to 100 in km/h to set to the train.'
    input
    input until ((@input.to_i >= 0) && (@input.to_i <= 100))
    @train_to_manipulate.speed = @input.to_i
    puts "The train #{@train_to_manipulate.train_number} go now #{@train_to_manipulate.speed} km/h."
  end

  def menu_go_next_station
    @train_to_manipulate.go_next_station
    puts "Train #{@train_to_manipulate.train_number} now on the #{@train_to_manipulate.current_station.name} station."
  end

  def menu_go_previous_station
    @train_to_manipulate.go_previous_station
    puts "Train #{@train_to_manipulate.train_number} now on the #{@train_to_manipulate.current_station.name} station."
  end
end

Menu.new.start