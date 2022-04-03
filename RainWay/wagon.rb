require_relative 'instanceCounter'

class Wagon
  include InstanceCounter
  include Manufacturer

  @@wagons_count = 1
  @@wagon_type = [:cargo, :passenger]

  attr_reader :type 
  attr_accessor :number

  def initialize(type, number = @@wagons_count)
    @type = type
    @number = String(@type == :cargo ? "cr#{number.to_s}" : "ps#{number.to_s}")
    validate!
    @@wagons_count += 1
    self.register_instance
  end

  def valid?
    validete!
  end

  protected
  def validate!
    errors = []
    errors << "Неверно определен тип вагона" if !@@wagon_type.include?(@type)
    errors << "Неверный формат номера вагона" if @number !~ /^(cr|ps)[0-9]*$/i
    errors << "Номер вагона не может быть пустым" if @number.nil?
    raise RailRoadExeption.new(errors.join("\n")) unless errors.empty?
    true
  end

end


