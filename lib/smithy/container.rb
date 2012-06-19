module Smithy
  class UnsatisfiedDependencyError < StandardError
    def initialize(dependency_name)
      super "Unmet dependency named #{dependency_name}"
    end
  end

  class Container
    def initialize
      @definitions = {}
      @instances = {}
    end

    def register(name, component, *dependency)
      if component.respond_to?(:new)
        @definitions[name] = [component, dependency]
      else
        @instances[name] = component
      end
    end

    def instance(name)
      return @instances[name] if @instances[name]
      component, dependency = @definitions[name]
      raise(UnsatisfiedDependencyError, name) unless component
      args = dependency.map {|service| self.instance(service) }
      @instances[name] = component.new(*args)
    end
  end
end
