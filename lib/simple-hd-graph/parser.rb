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
            resources << value
          end
        }

        resources.map { |resource|
          rn = ResourceNode.new
          rn.load_with_context({ id: context.id }, resource)
          context << rn
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
