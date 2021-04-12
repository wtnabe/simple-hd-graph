require 'dry/inflector'

module SimpleHdGraph
  class ResourceNode < Node
    def initialize(context)
      @context = context
      @inflector = Dry::Inflector.new
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
    # @param str [String]
    # @return [String]
    #
    def camelize(str)
      @inflector.camelize(@inflector.underscore(str))
    end
  end
end
