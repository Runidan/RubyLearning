require_relative 'instanceCounter'

class Wagon
  include InstanceCounter
  include Manufacturer

  @@wagons_count = 1

  attr_reader :type 
  attr_accessor :number

  def initialize(type, number = @@wagons_count)
    @type = type
    @number = number
    @@wagons_count += 1
    self.register_instance
  end

end


