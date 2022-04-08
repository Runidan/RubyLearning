class Test
  

  attr_reader :type

  def initialize(type, number)
    @type = type
    @number = number
    
  end

  def print_b
    a = self.class.b
    puts a
  end
end

class SonTest < Test
  def initialize(type = 0, number = 1)
    super(number, type)
    @type = :cargo
  end
end