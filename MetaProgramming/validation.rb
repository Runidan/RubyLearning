module Validation
  def self.validate(name, type, *args)
    raise unless type.is_sym?

  end

  def validate!
    self.class.validate
  end
end