module SimpleHdGraph
  class ContextNode < Node
    required :id

    attr_reader :resources

    #
    # @return [String]
    #
    def id
      @content[:id]
    end

    def <<(resource)
      @resources ||= []
      @resources << resource
    end
  end
end
