# frozen_string_literal: true

require_relative 'wagon'
require_relative 'instance_counter'

class CargoWagon < Wagon
  def initialize(place)
    super(:cargo, place, @@wagons_count)
  end

  def valid?
    validete!
  end

  def take_place(volume)
    raise RailRoadExeption, 'Недостаточно места' unless @place - @used_place >= volume

    @used_place += volume
  end

  protected

  def validate!
    errors = []
    errors << 'Неверно определен тип вагона' unless @@wagon_type.include?(@type)
    errors << 'Неверный формат номера вагона' if @number !~ /^cr[0-9]*$/i
    errors << 'Номер вагона не может быть пустым' if @number.nil?
    errors << 'Вместимость вагона не является числом' unless @place !~ /^\d*$/
    errors << 'Грузоподъемность вагона может быть от 0 до 200' unless (0..200).include?(@place)
    raise RailRoadExeption, errors.join("\n") unless errors.empty?

    true
  end
end
