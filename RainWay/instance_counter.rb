# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end

  module ClassMethods
    @@instances = 0

    def instances
      @@instances
    end

    def instances_set
      @@instances += 1
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.instances_set
    end
  end
end
