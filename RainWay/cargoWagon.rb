require_relative 'wagon'
require_relative 'instanceCounter'

class CargoWagon < Wagon

  def initialize
    @type = :cargo
    @@wagons_count += 1
    @wagon_number = @@wagons_count
    self.class.instances
  end

end 