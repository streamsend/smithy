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
        if dependency.any?
          @definitions[name] = [component, dependency]
        else
          @definitions[name] = [component, infer_dependency(component)]
        end
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

    private

    def infer_dependency(component)
      component.instance_method(:initialize).parameters.map do |_, name|
        name
      end
    end
  end
end
