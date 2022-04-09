# frozen_string_literal: true

require_relative 'station'
require_relative 'menu/menu'
require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'wagons/wagon'
require_relative 'wagons/cargo_wagon'
require_relative 'wagons/passenger_wagon'
require_relative 'trains/train'
require_relative 'trains/cargo_train'
require_relative 'trains/passenger_train'
require_relative 'route'
require_relative 'rail_road_exeption'

Menu.new.main_menu
