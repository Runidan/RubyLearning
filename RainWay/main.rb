# frozen_string_literal: true

require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'menu'
require_relative 'rail_road_exeption'
require_relative 'passenger_train'
require_relative 'cargo_train'

menu1 = Menu.new
tr1 = CargoTrain.new('sfs-123')

menu1.main_menu
