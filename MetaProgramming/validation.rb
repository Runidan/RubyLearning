module Validation

  module ClassMethods
    def validate(name, type, *args)
      raise TypeError.new("#{name}  is not symbol") unless name.is_a?(Symbol)
      raise TypeError.new("#{type}  is not symbol") unless type.is_a?(Symbol)
      raise TypeError.new("#{type}  может быть только :presence, :format или :type") unless [:presence, :format, :type].include?(type)
      
      arg = instance_variable_get("@#{name}")
      raise TypeError.new("#{name} не может быть пустым") if type == :presence && (arg.nil? || arg.empty?)
      raise TypeError.new("#{args[0]} не является регулярным выражением") if type == :format && !args[0].instance_of?(Regexp)
      raise TypeError.new("#{name} не соответствует регулярному выражению") if type == :format && arg !~ args[0]
      raise TypeError.new("#{args[0]} не является классом (третий аргумент)") if type == :type && !args[0].class.instance_of?(Class)
      raise TypeError.new("#{name} не является классом #{args[0]}") if arg == :type && !arg.instance_of?(args[0])
    end
  end
  
  module InstanceMethods
    
  end
end