# frozen_string_literal: true

require_relative './instance_counter'
require_relative './validation'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'station'
require_relative 'route'


class Menu
  def initialize; end

  def start
    puts 'Hello!'
    menu
  end

  private

  MENU_OPTIONS = <<-LIST
    Enter: 1, to create station, train, carriage or route for train.
    Enter: 2, to manipulate with created objects.
    Enter: 3, to look at list of created objects.
    Enter: 4, to test accessors.
    Enter: 0, to exit.'
  LIST

  MENU_CHOICE = {
    1 => :menu_1,
    2 => :menu_2,
    3 => :menu_3,
    4 => :test_accessors
  }.freeze

  MENU_1_OPTIONS = <<-LIST
    If you want to create:
    Enter: 1, to create station.
    Enter: 2, to create train.
    Enter: 3 to create route.
    Enter: 4 to create carriage.
    Enter: 5, go to the main menu.
    Enter: 0, to exit.
  LIST

  MENU_1_CHOICE = {
    1 => :create_station,
    2 => :menu_create_train,
    3 => :create_route,
    4 => :menu_create_carriage,
    5 => :menu
  }.freeze

  MENU_2_OPTIONS = <<-LIST
    Enter: 1, to manipulate with created routes.
    Enter: 2, to manipulate with created trains.
    Enter: 3, to manipulate with created carriages.
    Enter: 4, to go to the main menu.
    Enter: 0, to exit.
  LIST

  MENU_2_CHOICE = {
    1 => :menu_manipulate_routes,
    2 => :menu_manipulate_trains,
    3 => :menu_manipulate_carriages,
    4 => :menu
  }.freeze

  MENU_3_OPTIONS = <<-LIST
    Enter: 1, to look at created stations.
    Enter: 2, to look at created routes.
    Enter: 3, to look at created trains.
    Enter: 4, to look at trains on station.
    Enter: 5, to look at created carriages.
    Enter: 6, to look at carriages of some train.
    Enter: 7, to go to the main menu.
    Enter: 0, to exit.
  LIST

  MENU_3_CHOICE = {
    1 => :stations_list,
    2 => :routes_list,
    3 => :trains_list,
    4 => :trains_on_current_station_list,
    5 => :carriages_list,
    6 => :carriages_of_train_list,
    7 => :menu
  }.freeze

  MENU_CREATE_TRAIN_OPTIONS = <<-LIST
    Enter: 1, to create passenger train
    Enter: 2, to create cargo train
    Enter: 3, to go previous menu.
    Enter: 4, to go to the main menu.
    Enter: 0, to exit.
  LIST

  MENU_CREATE_TRAIN_CHOICE = {
    1 => :create_passenger_train,
    2 => :create_cargo_train,
    3 => :menu_1,
    4 => :menu
  }.freeze

  MENU_CREATE_CARRIAGE_OPTIONS = <<-LIST
    Enter: 1, to create passenger carriage.
    Enter: 2, to create cargo carriage.
    Enter: 3, to go previous menu.
    Enter: 0 to exit.
  LIST

  MENU_CREATE_CARRIAGE_CHOICE = {
    1 => :create_passenger_carriage,
    2 => :create_cargo_carriage,
    3 => :menu_1
  }.freeze

  MENU_MANIPULATE_ROUTE_OPTIONS = <<-LIST
    Enter: 1, to add station to the route.
    Enter: 2, to delete station from the route.
    Enter: 3, go to the train menu.
    Enter: 4, go to the main menu.
    Enter: 5, go to previous menu.
    Enter: 0, to exit.
  LIST

  MENU_MANIPULATE_ROUTE_CHOICE = {
    1 => :add_station,
    2 => :delete_station,
    3 => :menu_manipulate_trains,
    4 => :menu,
    5 => :menu_2
  }.freeze

  MENU_MANIPULATE_TRAINS_OPTIONS = <<-LIST
    Enter: 1, to set a route to a train.
    Enter: 2, to add a carriage to a train.
    Enter: 3, to delete a carriage from a train.
    Enter: 4, to set a speed to a train.
    Enter: 5, to go next station.
    Enter: 6, to go previous station.
    Enter: 7, to stop a train.
    Enter: 8, go to the main menu.
    Enter: 9, go to previous menu.
    Enter: 0, to exit.
  LIST

  MENU_MANIPULATE_TRAINS_CHOICE = {
    1 => :set_route,
    2 => :menu_add_carriage,
    3 => :menu_delete_carriage,
    4 => :menu_set_speed,
    5 => :menu_go_next_station,
    6 => :menu_go_previous_station,
    7 => :stop_train!,
    8 => :menu,
    9 => :menu_2
  }.freeze

  MENU_MANIPULATE_CARRIAGES_OPTIONS = <<-LIST
    Enter: 1, to add or delete a carriage to/from a train.'
    Enter: 2, to take a seat in a passenger carriage.'
    Enter: 3, to take volume of cargo carriage.'
    Enter: 4, to go to the main menu.'
    Enter: 0, to exit.'
  LIST

  MENU_MANIPULATE_CARRIAGES_CHOICE = {
    1 => :menu_manipulate_trains,
    2 => :take_seat_of_chosen_carriage,
    3 => :take_volume_of_chosen_carriage,
    4 => :menu
  }.freeze

  MENU_CHOOSE_TRAIN_OPTIONS = <<-LIST
    Enter: 1, to choose passenger train.'
    puts 'Enter: 2, to choose cargo train.'
    puts 'Enter: 3, to go to the main menu.'
    puts 'Enter: 0, to exit'
  LIST

  MENU_CHOOSE_TRAIN_CHOICE = {
    1 => :choose_passenger_train,
    2 => :choose_cargo_train,
    3 => :menu
  }.freeze

  MENU_ADD_CARRIAGE_OPTIONS = <<-LIST
    Enter: 1, to add passenger carriage.
    Enter: 2, to add cargo carriage.
    Enter: 3, go to the main menu.
    Enter: 4, go to previous menu.
    Enter: 0, to exit.
  LIST

  MENU_ADD_CARRIAGE_CHOICE = {
    1 => :add_chosen_pass_carriage,
    2 => :add_chosen_cargo_carriage,
    3 => :menu,
    4 => :menu_manipulate_trains
  }.freeze

  def input_to_i
    @input = gets.chomp.to_i
    exit? ? exit! : @input
  end

  def input
    @input = gets.chomp
  end

  def menu
    puts MENU_OPTIONS
    send MENU_CHOICE[input_to_i]
  rescue TypeError
    puts 'Invalid input!'
    retry
  end

  def menu_1
    puts MENU_1_OPTIONS
    send MENU_1_CHOICE[input_to_i]
    menu_1
  rescue TypeError
    puts 'Invalid input!'
    retry
  end

  def menu_2
    puts MENU_2_OPTIONS
    send MENU_2_CHOICE[input_to_i]
    menu_2
  rescue TypeError
    puts 'Invalid input!'
    retry
  end

  def menu_3
    puts MENU_3_OPTIONS
    send MENU_3_CHOICE[input_to_i]
    menu_3
  rescue StandardError
    p @input
    p @input.class
    puts 'Invalid input!'
    retry
  end

  def menu_create_train
    puts MENU_CREATE_TRAIN_OPTIONS
    send MENU_CREATE_TRAIN_CHOICE[input_to_i]
  rescue TypeError
    puts 'Invalid input!'
    retry
  end

  def menu_create_carriage
    puts MENU_CREATE_CARRIAGE_OPTIONS
    send MENU_CREATE_CARRIAGE_CHOICE[input_to_i]
  rescue TypeError
    puts 'Invalid input!'
    retry
  end

  def menu_manipulate_routes
    puts MENU_MANIPULATE_ROUTE_OPTIONS
    send MENU_MANIPULATE_ROUTE_CHOICE[input_to_i]
    menu_manipulate_routes
  rescue TypeError
    puts 'Invalid input!'
    retry
  end

  def menu_manipulate_trains
    menu_choose_train
    puts MENU_MANIPULATE_TRAINS_OPTIONS
    send MENU_MANIPULATE_TRAINS_CHOICE[input_to_i]
    menu_manipulate_trains
  rescue TypeError
    puts 'Invalid input!'
    retry
  end

  def menu_manipulate_carriages
    puts MENU_MANIPULATE_CARRIAGES_OPTIONS
    send MENU_MANIPULATE_CARRIAGES_CHOICE[input_to_i]
    menu_manipulate_carriages
  rescue TypeError
    puts 'Invalid input!'
    retry
  end

  def menu_choose_train
    puts MENU_CHOOSE_TRAIN_OPTIONS
    send MENU_CHOOSE_TRAIN_CHOICE[input_to_i]
  rescue TypeError
    puts 'Invalid input!'
    retry
  end

  def menu_add_carriage
    puts MENU_ADD_CARRIAGE_OPTIONS
    send MENU_ADD_CARRIAGE_CHOICE[input_to_i]
  rescue TypeError
    puts 'Invalid input!'
    retry
  end

  def create_station_input
    puts "Enter: station's name."
    input
    @stations ||= []
    @stations << Station.new(@input)
  end

  def create_station
    create_station_input
  rescue StandardError => e
    puts e.message
    retry
  ensure
    puts "Station #{@input} was created."
  end

  def create_route_input
    stations_list
    puts 'Enter: sequence number of start station; than of and station.'
    input_to_i
    valid_input!(@stations)
    start_station = @stations[@input - 1]
    input_to_i until valid_input?(@stations) && @stations[@input - 1] != start_station
    end_station = @stations[@input - 1]
    @routes ||= []
    @routes << Route.new(start_station, end_station)
  end

  def create_route
    stations_exist_validate!
    can_create_route_validate!
    create_route_input
    puts 'New route was created.'
  rescue StandardError => e
    puts e.message
  end

  def create_passenger_train
    puts "Enter: train's number:"
    @trains ||= []
    @trains << PassengerTrain.new(input)
  rescue StandardError => e
    puts e.message
    retry
  ensure
    puts "Passenger train #{@input} was created."
  end

  def create_cargo_train
    puts "Enter: train's number:"
    @trains ||= []
    @trains << CargoTrain.new(input)
  rescue StandardError => e
    puts e.message
    retry
  ensure
    puts "Cargo train #{@input} was created."
  end

  def create_passenger_carriage_input
    puts 'Enter: passenger carriage number.'
    number = input
    puts 'enter: number of seats:'
    seats = input_to_i
    @carriages ||= []
    @carriages << PassengerCarriage.new(number, seats)
    puts "Passenger carriage #{number} with #{seats} was created."
  end

  def create_passenger_carriage
    create_passenger_carriage_input
  rescue StandardError => e
    puts e.message
    retry
  end

  def create_cargo_carriage_input
    puts 'Enter: cargo carriage number.'
    number = input
    puts 'Enter: volume of carriage.'
    volume = input_to_i
    @carriages ||= []
    @carriages << CargoCarriage.new(number, volume)
    puts "Cargo carriage #{number} with volume: #{volume} was created."
  end

  def create_cargo_carriage
    create_cargo_carriage_input
  rescue StandardError => e
    puts e.message
    retry
  end

  def add_station
    routes_exist_validate!
    route_index ||= chose_route_index
    station_index ||= chose_station_index
    add_station_validate!(route_index, station_index)
    @routes[route_index].add_station(@stations[station_index])
    puts "Station #{@stations[station_index].name} added to the route."
  rescue StandardError => e
    puts e
  end

  def delete_station
    routes_exist_validate!
    route_index ||= chose_route_index
    station_index ||= chose_station_index
    min_routes_size_validate!(route_index)
    delete_station_validate!(route_index, station_index)
    @routes[route_index].delete_station(@stations[station_index])
    puts "Station #{@stations[@input.to_i - 1].name} deleted from the chosen route."
  rescue StandardError => e
    puts e
  end

  def chose_route_index
    puts 'Choose route:'
    routes_list
    input_to_i
    valid_input!(@routes)
    @input.to_i - 1
  end

  def chose_station_index
    puts 'Choose station:'
    # TODO: change later .stations_list on list of stations of chosen route.
    stations_list
    input_to_i
    valid_input!(@stations)
    @input.to_i - 1
  end

  def choose_train_input
    puts 'Enter train number.'
    input
    input until Train.find(@input)
    @train = Train.find(@input)
    puts "Train #{@train.number} was chosen."
  end

  def choose_train(type)
    choose_train_validate!(type)
    choose_train_input
  rescue StandardError => e
    puts e
    menu_create_train
  end

  def choose_passenger_train
    pass_trains_list
    choose_train('pass')
  end

  def choose_cargo_train
    cargo_trains_list
    choose_train('cargo')
  end

  def set_route
    routes_list
    puts 'Enter sequence number of route.'
    input
    valid_input!(@routes)
    @train.current_route = @routes[@input.to_i - 1]
    puts "The route #{@routes[@input.to_i - 1]} was set to the train #{@train.number}"
  rescue StandardError => e
    puts e
  end

  def choose_carriage_input
    puts 'Enter carriage number:'
    input
    input until carriage_by_number(@input)
    @carriage = carriage_by_number(@input)
    puts "Carriage #{@carriage.number} was chosen."
  end

  def choose_carriage(type)
    carriages_validate!(type)
    carriages_list(type)
    choose_carriage_input
  rescue StandardError => e
    puts e
    menu_create_carriage
  end

  def carriage_by_number(number)
    @carriages.find { |carriage| carriage.number == number }
  end

  def take_seat_of_chosen_carriage
    choose_carriage('pass')
    @carriage.take_seat
    puts "You've taken 1 seat in #{@carriage.number}."
  rescue StandardError => e
    puts e.message
  end

  def take_volume_of_chosen_carriage
    choose_carriage('cargo')
    puts 'Enter: number of volume, you want to take.'
    @carriage.take_volume(input.to_i)
  rescue StandardError => e
    puts e.message
    retry
  ensure
    puts "You've taken #{@input} volume of #{@carriage.number}."
  end

  # TODO: Later if possible to give argument as method,
  #  than refactor with current method methods such as 'objects_list'
  #  def objects_list(objects, method)
  #    objects.each do |object|
  #    puts "#{objects.index(object) + 1}: #{object.method}"
  #    end
  #  end

  def stations_list
    stations_exist_validate!
    puts 'Stations:'
    @stations.each do |station|
      puts "#{@stations.index(station) + 1}: #{station.name}"
    end
  rescue StandardError
    puts 'Firstly create some station.'
  end

  def routes_list
    routes_validate!
    puts 'Routes:'
    @routes.each { |route| puts "#{@routes.index(route) + 1}: #{route.to_s}" }
  end

  def trains_list
    @trains.each { |train| puts "#{train.number} - #{train.type}" }
  rescue StandardError
    puts 'Firstly create some train.'
  end

  def pass_trains_list
    puts 'Passenger trains:'
    pass_trains = @trains.select { |train| train.type == 'pass' }
    pass_trains.each { |train| puts train.number.to_s }
  rescue StandardError
    puts 'Firstly create some train.'
  end

  def cargo_trains_list
    puts 'Cargo trains:'
    cargo_trains = @trains.select { |train| train.type == 'cargo' }
    cargo_trains.each { |train| puts train.number.to_s }
  rescue StandardError
    puts 'Firstly create some train.'
  end

  def trains_on_current_station_list_input
    stations_list
    puts 'Enter sequence number of station'
    input_to_i
    valid_input!(@stations)
    station_sequence_number = @input
    puts "Trains on station #{@stations[station_sequence_number - 1].name}:"
    train_on_station_validate!(station_sequence_number)
    @stations[station_sequence_number - 1].to_s
  end

  def trains_on_current_station_list
    stations_exist_validate!
    trains_on_current_station_list_input
  rescue StandardError => e
    puts e
  end

  def passenger_carriages_list
    puts 'Passenger carriages:'
    pass_carriages = @carriages.select { |carriage| carriage.type == 'pass' }
    pass_carriages.each do |carriage|
      puts "Number: #{carriage.number}, free seats: #{carriage.free_seats}."
    end
  rescue StandardError
    puts 'Firstly create some carriage.'
  end

  def cargo_carriages_list
    puts 'Cargo carriages:'
    cargo_carriages = @carriages.select { |carriage| carriage.type == 'cargo' }
    cargo_carriages.each do |carriage|
      puts "Number: #{carriage.number}, free_volume: #{carriage.free_volume}."
    end
  rescue StandardError
    puts 'Firstly create some carriage.'
  end

  def carriages_list(type = 'all')
    if type == 'pass'
      passenger_carriages_list
    elsif type == 'cargo'
      cargo_carriages_list
    else
      passenger_carriages_list
      cargo_carriages_list
    end
  end

  def train_carriages_list
    puts "Carriages of the train #{@train.number}"
    @train.carriages.each do |carriage|
      puts "#{@train.carriages.index(carriage) + 1}: #{carriage.number}"
    end
  rescue StandardError
    puts 'Firstly add some carriage to the train.'
  end

  def carriages_of_train_list
    menu_choose_train
    @train.carriages_to_s
  rescue StandardError
    puts 'Firstly add some carriage to the train.'
  end

  def route_stations_list
    puts 'Stations of the current route:'
    i = @input.to_i - 1
    @routes[i].each { |station| puts "#{@routes[i].index(station) + 1}: #{station.name}" }
  end

  def add_chosen_carriage
    @train.add_carriage(@carriage)
    puts "Carriage #{@carriage.number} added to the train #{@train.number}."
  rescue StandardError => e
    puts e.message
  end

  def add_chosen_pass_carriage
    # passenger_carriages_list
    choose_carriage('pass')
    add_chosen_carriage
  end

  def add_chosen_cargo_carriage
    # cargo_carriages_list
    choose_carriage('cargo')
    add_chosen_carriage
  end

  def menu_delete_carriage
    train_carriages_list
    choose_carriage(@train.type)
    @train.delete_carriage(@carriage)
    puts "Carriage #{@carriage.number} was deleted from train #{@train.number}"
  rescue StandardError => e
    puts e.message
  end

  def menu_set_speed
    puts 'Enter number of speed from 0 to 100 in km/h to set to the train.'
    input
    input until (@input.to_i >= 0) && (@input.to_i <= 100)
    @train.speed = @input.to_i
    puts "The train #{@train.number} go now #{@train.speed} km/h."
  end

  def stop_train!
    @train.speed = 0
    puts "Speed of the train #{@train.number} now is 0 km/h. "
  end

  def menu_go_next_station
    set_route until @train.current_route
    @train.go_next_station
    puts "Train #{@train.number} on the #{@train.current_station.name} station."
  rescue StandardError => e
    puts e.message
  end

  def menu_go_previous_station
    set_route until @train.current_route
    @train.go_previous_station
    puts "Train #{@train.number} on the #{@train.current_station.name} station."
  rescue StandardError => e
    puts e.message
  end

  def exit?
    @input.zero?
  end

  def exit!
    puts 'Good buy!'
    exit(0)
  end

  def valid_input?(arr)
    @input.to_i.positive? && @input.to_i <= arr.size
  end

  def valid_input!(arr)
    raise 'Invalid input' unless valid_input?(arr)
  end

  def can_create_route_validate!
    raise 'Firstly create at least 2 stations.' if @stations.size < 2
  end

  def stations_exist_validate!
    raise 'Firstly create at least one station.' unless @stations
  end

  def train_on_station_validate!(station_sequence_number)
    raise 'there is no train, yet.' unless @stations[station_sequence_number - 1].trains
  end

  def routes_exist_validate!
    raise 'Firstly create some route.' unless @routes
  end

  def min_routes_size_validate!(route_index)
    return unless @routes[route_index].stations.size == 2

    raise "Route should have at least 2 stations. You can't delete anymore station."
  end

  def choose_train_validate!(type)
    raise 'Firstly create some train!' unless @trains

    return unless @trains.select { |train| train.type == type }.empty?

    raise "Firstly create some #{type} train."
  end

  def routes_validate!
    raise 'Firstly create some route.' unless @routes
  end

  def carriages_validate!(type)
    raise 'Firstly create some carriage.' unless @carriages

    return unless @carriages.select { |carriage| carriage.type == type }.empty?

    raise "Firstly create some #{type} carriage"
  end

  def add_station_validate!(route_index, station_index)
    return unless @routes[route_index].stations.include?(@stations[station_index])

    raise 'Route is already include chosen station.'
  end

  def delete_station_validate!(route_index, station_index)
    return if @routes[route_index].stations.include?(@stations[station_index])

    raise "Route does't have chosen station"
  end

  #rubocop:disable all
  def test_accessors
    e = Train.new('eeeee')
    puts "Train created: #{e}."
    e.manufacturer='First'
    puts "Manufacturer: #{e.manufacturer}"
    e.manufacturer='New'
    puts "New manufacturer: #{e.manufacturer}"
    puts "Manufacturer history: #{e.manufacturer_history}"
    print "Test valid value for strong accessors: "
    puts "#{e.test = 'Europe'}"
    print "Test INvalid value for strong accessors: "
    e.test = 67
    puts "Check value after invalid input, should be 'Europe': #{e.test}."
    puts "\n"
    menu
  end
  #rubocop:enable all
end

Menu.new.start
