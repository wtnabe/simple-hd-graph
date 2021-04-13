module SimpleHdGraph
  class ResourceNode < Node
    #
    # @param context [Object]
    # @param struct [Hash]
    #
    def load_with_context(context, struct)
      @context = context
      load(struct)
    end

    #
    # @return [String]
    #
    def alias
      @content.keys.first.to_s.freeze
    end

    #
    # @return [String]
    #
    def id
      id = camelize(context)
      id[0] = id[0].downcase
      [id, camelize(self.alias)].join('').freeze
    end

    #
    # @return [String]
    #
    def context
      @context[:id].freeze
    end

    #
    # @return [Hash]
    #
    def content
      @content.values.first
    end
  end
end
