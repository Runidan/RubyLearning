require_relative 'wagon'
require_relative 'instanceCounter'

class PassengerWagon < Wagon

  def initialize
    @type = :passenger
    @@wagons_count += 1
    @wagon_number = @@wagons_count
    self.class.instances
  end

end  