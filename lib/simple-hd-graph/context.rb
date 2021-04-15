module SimpleHdGraph
  class ContextNode < Node
    required :id

    attr_reader :resources, :relation

    #
    # @return [String]
    #
    def alias
      @content[:id]
    end

    #
    # @return [String]
    #
    def id
      id = camelize(self.alias)
      id[0] = id[0].downcase
      id
    end

    def <<(resource)
      @resources ||= []
      @resource_dict ||= {}
      @resources << resource
      @resource_dict[resource.alias] = resource.id
    end

    #
    # :reek:NestedIterators
    def refill_relation
      @relation ||= []
      @resources.each { |resource|
        dependencies = resource.has
        if dependencies
          dependencies.each { |dependency|
            @relation << { resource.id => @resource_dict[dependency] }
          }
        end
      }
    end
  end
end
