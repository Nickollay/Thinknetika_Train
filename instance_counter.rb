module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instances ||= 0
    end

    def add_instance
      @instances ||= 0
      @instances += 1
    end
  end

  module InstanceMethods

    def initialize
      register_instance
    end

    private

    def register_instance
      self.class.add_instance
    end
  end
end