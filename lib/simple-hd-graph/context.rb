require 'simple-hd-graph/node'

module SimpleHdGraph
  class ContextNode < Node
    required :id

    attr_reader :resources, :relations, :depends # Array

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

    #
    # @param resource [ResourceNode]
    #
    def <<(resource)
      @resources ||= []
      @resource_dict ||= {}
      @resources << resource
      @resource_dict[resource.alias] = resource.id
    end

    #
    # @param depends [Array]
    #
    def set_depends(depends)
      @depends = depends
    end

    # :reek:NestedIterators, :reek:TooManyStatements
    def refill_relation
      @resource  ||= []
      @relations ||= []
      @resources.each { |resource|
        dependencies = resource.has
        if dependencies
          dependencies.each { |dependency|
            @relations << { resource.id => @resource_dict[dependency] }
          }
        end
      }
    end
  end
end
