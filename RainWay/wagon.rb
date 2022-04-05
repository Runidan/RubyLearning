require_relative 'instanceCounter'
require_relative 'manufacturer'

class Wagon
  include InstanceCounter
  include Manufacturer

  @@wagons_count = 1
  @@wagon_type = [:cargo, :passenger]

  attr_reader :type, :place, :taked_place
  attr_accessor :number

  def initialize(type, place, number = @@wagons_count)
    @type = type
    @number = String(@type == :cargo ? "cr#{number.to_s}" : "ps#{number.to_s}")
    @place = place
    validate!
    @used_place = 0
    @@wagons_count += 1
    self.register_instance
  end

  def valid?
    validete!
  end

  def free_place
    @place - @used_place
  end

  protected
  def validate!
    errors = []
    errors << "Неверно определен тип вагона" if !@@wagon_type.include?(@type)
    errors << "Неверный формат номера вагона" if @number !~ /^(cr|ps)[0-9]*$/i
    errors << "Номер вагона не может быть пустым" if @number.nil?
    errors << "Вместимость вагона не является целым числом" unless @place.integer?
    raise RailRoadExeption.new(errors.join("\n")) unless errors.empty?
    true
  end

end


