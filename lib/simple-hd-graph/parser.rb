require 'yaml'

module SimpleHdGraph
  #
  # parse for YAML string
  #
  # :reek:InstanceVaariableAssumption
  class Parser
    #
    # @param document [String]
    #
    # :reek:TooManyStatements
    def parse(document)
      contexts = []

      YAML.load_stream(document) do |node|
        context   = nil
        resources = []

        # :reek:NestedIterators
        node.each_pair { |key, value|
          if key == 'id'
            context = ContextNode.new
            context.load({ id: value })
          elsif reserved_keywords.include?(key)
          else
            resources << { key => value }
          end
        }

        resources.map {
          context << ResourceNode.new({ id: context.id })
        }
        contexts << context
      end

      contexts
    end

    #
    # @return [Array]
    #
    def reserved_keywords
      [:depends]
    end
  end
end
