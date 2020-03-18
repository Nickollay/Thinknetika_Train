# !!!! For now file main.rb only for testing other classes.
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
    case input
    when '1'
      menu_manipulate_routes
    when '2'
      menu_manipulate_trains
    when '3'
      menu_manipulate_carriages
    when '4'
      menu
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
    case input
    when '1'
      created_stations_list
    when '2'
      @created_routes.each do |route|
        print "#{@created_routes.index(route) + 1}: "
        route.to_s
      end
    when '3'
      puts 'Passenger trains:'
      @created_pass_trains.each { |train| puts "#{@created_pass_trains.index(train) + 1}: #{train.train_number}" }
      puts 'Cargo trains:'
      @created_cargo_trains.each { |train| puts "#{@created_cargo_trains.index(train) + 1}: #{train.train_number}" }
    when '4'
      created_stations_list

    when '5'
      menu
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
    @created_stations << Station.new(input)
    puts "Station #{@input} was created."
  end

  def menu_create_route
    #add later message of invalid input.
    puts 'Enter: number of start station.'
    input
    input until valid_input?(@created_stations)
    start_station = @created_stations[@input.to_i - 1]
    puts 'Enter: number of end station.'
    input until valid_input?(@created_stations) && @created_stations[@input.to_i - 1] != start_station
    end_station = @created_stations[@input.to_i - 1]
    @created_routes << Route.new(start_station, end_station)
    puts 'New route was created.'
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
    menu_create_train
  end

  def menu_create_carriage
    puts 'Enter: 1, to create passenger carriage.'
    puts 'Enter: 2, to create cargo carriage.'
    puts 'Enter: 3, to go previous menu.'
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
      puts 'Wrong input!'
    end
  end

  def menu_manipulate_routes
    #Maybe later, before:
    # 1) should show all created routs with from array @created_routs in format,
    # index_number - object: 1. arr[0], 2. arr[1]..
    # 2) choose route to manipulate.
    puts 'Enter: 1, to add station to the route.'
    puts 'Enter: 2, to delete station from the route.'
    puts 'Enter: 3, go to the train menu.'
    puts 'Enter: 4, go to the main menu.'
    puts 'Enter: 5, go to previous menu.'
    case input
    when '1'
      input
      # shold use Route::add_way_station
      #@created_routes << @created_stations[@input] until @created_routes.include?(@created_stations[@input])
      #puts 'Station added to the route'
    end
  end

  def menu_manipulate_trains

  end

  def menu_manipulate_carriages

  end


  def valid_input?(arr)
    @input.to_i > 0 && @input.to_i <= arr.size
  end

  def created_stations_list
    @created_stations.each { |station| puts "#{@created_stations.index(station) + 1}: #{station.name}" }
  end

end

Menu.new.start