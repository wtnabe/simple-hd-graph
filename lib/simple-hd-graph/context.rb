module SimpleHdGraph
  class ContextNode < Node
    required :id

    #
    # @return [String]
    #
    def id
      @content[:id]
    end
  end
end
