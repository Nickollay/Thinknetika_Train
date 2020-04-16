# frozen_string_literal: true

require_relative './instance_counter'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'cargo_carriage'
require_relative 'passenger_carriage'
require_relative 'station'
require_relative 'route'

# remove this line!
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
    Enter: exit, to exit.'
  LIST

  MENU_CHOICE = {
    1 => :menu_1,
    2 => :menu_2,
    3 => :menu_3
  }.freeze

  MENU_1_OPTIONS = <<-LIST
    If you want to create:
    Enter: 1, to create station.
    Enter: 2, to create train.
    Enter: 3 to create route.
    Enter: 4 to create carriage.
    Enter: 5, go to the main menu.
    Enter: exit, to exit.
  LIST

  MENU_1_CHOICE = {
    1 => :menu_create_station,
    2 => :menu_create_train,
    3 => :menu_create_route,
    4 => :menu_create_carriage,
    5 => :menu
  }.freeze

  MENU_2_OPTIONS = <<-LIST
    Enter: 1, to manipulate with created routes.
    Enter: 2, to manipulate with created trains.
    Enter: 3, to manipulate with created carriages.
    Enter: 4, to go to the main menu.
    Enter: exit, to exit.
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
    Enter: exit, to exit.
  LIST

  MENU_3_CHOICE = {
    1 => :stations_list,
    2 => :routes_list,
    3 => :trains_list,
    4 => :show_trains_on_current_station,
    5 => :carriages_list,
    6 => :carriages_of_train_list,
    7 => :menu
  }.freeze

  MENU_CREATE_TRAIN_OPTIONS = <<-LIST
    Enter: 1, to create passenger train
    Enter: 2, to create cargo train
    Enter: 3, to go previous menu.
    Enter: 4, to go to the main menu.
    Enter: exit, to exit.
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
    Enter: exit to exit.
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
    Enter: exit, to exit.
  LIST

  MENU_MANIPULATE_ROUTE_CHOICE = {
    1 => :menu_add_station,
    2 => :menu_delete_station,
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
    Enter: exit, to exit.
  LIST

  MENU_MANIPULATE_TRAINS_CHOICE = {
    1 => :menu_set_route,
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
    Enter: exit, to exit.'
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
    puts 'Enter: exit, to exit'
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
    Enter: exit, to exit.
  LIST

  MENU_ADD_CARRIAGE_CHOICE = {
    1 => :add_chosen_pass_carriage,
    2 => :add_chosen_cargo_carriage,
    3 => :menu,
    4 => :menu_manipulate_trains
  }.freeze

  # Refactore methods to use input_to_i,
  # than delete .input and rename .input_to_i into .input.
  def input_to_i
    @input = gets.chomp
    exit? ? exit! : @input.to_i
  end

  def input
    @input = gets.chomp
    exit? ? exit! : @input
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
  rescue StandardError
    puts 'Invalid input!'
    retry
  end

  def menu_3
    puts MENU_3_OPTIONS
    send MENU_3_CHOICE[input_to_i]
    menu_3
  rescue StandardError
    puts 'Invalid input!'
    retry
  end

  def menu_create_train
    puts MENU_CREATE_TRAIN_OPTIONS
    send MENU_CREATE_TRAIN_CHOICE[input_to_i]
  rescue StandardError
    puts 'Invalid input!'
    retry
  end

  def menu_create_carriage
    puts MENU_CREATE_CARRIAGE_OPTIONS
    send MENU_CREATE_CARRIAGE_CHOICE[input_to_i]
  rescue StandardError
    puts 'Invalid input!'
    retry
  end

  def menu_manipulate_routes
    puts MENU_MANIPULATE_ROUTE_OPTIONS
    send MENU_MANIPULATE_ROUTE_CHOICE[input_to_i]
    menu_manipulate_routes
  rescue StandardError
    puts 'Invalid input!'
    retry
  end

  def menu_manipulate_trains
    menu_choose_train
    puts MENU_MANIPULATE_TRAINS_OPTIONS
    send MENU_MANIPULATE_TRAINS_CHOICE[input_to_i]
    menu_manipulate_trains
  rescue StandardError
    puts 'Invalid input!'
    retry
  end

  def menu_manipulate_carriages
    puts MENU_MANIPULATE_CARRIAGES_OPTIONS
    send MENU_MANIPULATE_CARRIAGES_CHOICE[input_to_i]
    menu_manipulate_carriages
  rescue StandardError
    puts 'Invalid input!'
    retry
  end

  def menu_choose_train
    puts MENU_CHOOSE_TRAIN_OPTIONS
    send MENU_CHOOSE_TRAIN_CHOICE[input_to_i],
         menu_choose_train
  rescue StandardError
    puts 'Invalid input!'
    retry
  end

  def menu_add_carriage
    puts MENU_ADD_CARRIAGE_OPTIONS
    send MENU_ADD_CARRIAGE_CHOICE[input_to_i]
  rescue StandardError
    puts 'Invalid input!'
    retry
  end

  def menu_create_station
    puts "Enter: station's name."
    input
    @stations ||= []
    @stations << Station.new(@input)
  rescue StandardError => e
    puts e.message
    retry
  ensure
    puts "Station #{@input} was created."
  end

  def menu_create_route
    if @stations.nil? || @stations.size < 2
      puts 'Firstly create at least 2 stations.'
      menu_create_station
    else
      begin
        stations_list
        puts 'Enter: sequence number of start station.'
        input
        input until valid_input?(@stations)
        start_station = @stations[@input.to_i - 1]
        puts 'Enter: sequence number of end station.'
        input until valid_input?(@stations) && @stations[@input.to_i - 1] != start_station
        end_station = @stations[@input.to_i - 1]
        @routes ||= []
        @routes << Route.new(start_station, end_station)
      rescue StandardError => e
        puts e.message
        retry
      ensure
        puts 'New route was created.'
      end
    end
  end

  def create_passenger_carriage
    puts 'Enter: passenger carriage number.'
    input
    number = @input
    puts 'enter: number of seats:'
    input
    seats = @input.to_i
    @carriages ||= []
    @carriages << PassengerCarriage.new(number, seats)
  rescue StandardError => e
    puts e.message
    retry
  ensure
    puts "Passenger carriage #{number} with #{seats} was created."
  end

  def create_cargo_carriage
    puts 'Enter: cargo carriage number.'
    input
    number = @input
    puts 'Enter: volume of carriage.'
    input
    volume = @input.to_i
    @carriages ||= []
    @carriages << CargoCarriage.new(number, volume)
  rescue StandardError => e
    puts e.message
    retry
  ensure
    puts "Cargo carriage #{number} with volume: #{volume} was created."
  end

  def take_seat_of_chosen_carriage
    choose_carriage('pass')
    @carriage.take_seat
  rescue StandardError => e
    puts e.message
    retry
  ensure
    puts "You've taken 1 seat in #{@carriage.number}."
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

  def valid_input?(arr)
    @input.to_i.positive? && @input.to_i <= arr.size
  end

  # Later if possible to give argument as method,
  # than refactor with current method methods such as 'objects_list'
  # def objects_list(objects, method)
  #   objects.each do |object|
  #     puts "#{objects.index(object) + 1}: #{object.method}"
  #     end
  # end

  def stations_list
    puts 'Stations:'
    @stations.each do |station|
      puts "#{@stations.index(station) + 1}: #{station.name}"
    end
  rescue StandardError
    puts 'Firstly create some station.'
  end

  def routes_list
    puts 'Routes:'
    @routes.each { |route| puts "#{@routes.index(route) + 1}: #{route.to_s}" }
  rescue StandardError
    puts 'Firstly create some route.'
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

  def show_trains_on_current_station
    if !@stations
      puts 'Firstly create some stations'
      menu_create_station
    else
      stations_list
      puts 'Enter sequence number of station'
      input until valid_input?(@stations)
      station_sequence_number = @input.to_i
      puts "Trains on station #{@stations[station_sequence_number - 1].name}:"
      if !@stations[station_sequence_number - 1].trains
        puts 'there no train, yet.'
      else
        @stations[station_sequence_number - 1].to_s
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
      puts "Station #{@stations[@input.to_i - 1].name} added to the route."
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

  def choose_passenger_train
    pass_trains_list
    choose_train('pass')
  end

  def choose_cargo_train
    cargo_trains_list
    choose_train('cargo')
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
      @train.current_route = @routes[@input.to_i - 1]
      puts "The route #{@routes[@input.to_i - 1]} was set to the train #{@train.number}"
    end
  end

  def choose_carriage(type)
    if !@carriages
      puts 'Firstly create some carriage.'
      menu_create_carriage
      @carriage = carriages[0]
    elsif @carriages.select { |carriage| carriage.type == type }.empty?
      puts "Firstly create some #{type} carriage"
      menu_create_carriage
      @carriage = @carriages.find { |carriage| carriage.type == type }
      puts "Carriage #{@carriage.number} was chosen."
    else
      carriages_list(type)
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
    if @train && @carriage
      @train.add_carriage(@carriage)
      puts "Carriage #{@carriage.number} added to the train #{@train.number}."
    elsif !@train
      puts 'Firstly choose some train.'
      menu_choose_train
      add_chosen_carriage
    elsif !@carriage
      puts 'Firstly choose some carriage.'
      menu_add_carriage
    end
  rescue StandardError => e
    puts e.message
  end

  def add_chosen_pass_carriage
    passenger_carriages_list
    choose_carriage('pass')
    add_chosen_carriage
  end

  def add_chosen_cargo_carriage
    cargo_carriages_list
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
    menu_set_route until @train.current_route
    @train.go_next_station
    puts "Train #{@train.number} on the #{@train.current_station.name} station."
  rescue StandardError => e
    puts e.message
  end

  def menu_go_previous_station
    menu_set_route until @train.current_route
    @train.go_previous_station
    puts "Train #{@train.number} on the #{@train.current_station.name} station."
  rescue StandardError => e
    puts e.message
  end

  def exit?
    @input == 'exit'
  end

  def exit!
    puts 'Good buy!'
    exit(0)
  end
end

Menu.new.start
