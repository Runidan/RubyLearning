# frozen_string_literal: true

require_relative 'wagon'
require_relative 'instance_counter'

class PassengerWagon < Wagon
  def initialize(place)
    super(:passenger, place, @@wagons_count)
  end

  def valid?
    validete!
  end

  def take_place
    raise RailRoadExeption, 'Свободных мест нет' unless @place > @used_place

    @used_place += 1
  end

  protected

  def validate!
    errors = []
    errors << 'Неверно определен тип вагона' unless @@wagon_type.include?(@type)
    errors << 'Неверный формат номера вагона' if @number !~ /^ps[0-9]*$/i
    errors << 'Номер вагона не может быть пустым' if @number.nil?
    errors << 'Вместимость вагона не является целым числом' unless @place.integer?
    errors << 'Вместимость вагона может быть от 0 до 150' unless @place.between? 0, 150
    raise RailRoadExeption, errors.join("\n") unless errors.empty?

    true
  end
end
