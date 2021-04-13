module SimpleHdGraph
  class ContextNode < Node
    required :id

    attr_reader :resources

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
      @resources << resource
    end
  end
end
