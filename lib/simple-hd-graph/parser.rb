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
          elsif key == 'resources'
            resources = value
          end
        }

        resources.each { |key, resource|
          rn = ResourceNode.new
          rn.load_with_context({ id: context.id }, { key => resource })
          context << rn
        }
        contexts << context
      end
      refill_relation(contexts)

      contexts
    end

    #
    # @param contexts [Array]
    #
    def refill_relation(contexts)
      contexts.each {|context|
        context.refill_relation
      }
    end

    #
    # @return [Array]
    #
    def reserved_keywords
      [:depends]
    end
  end
end
