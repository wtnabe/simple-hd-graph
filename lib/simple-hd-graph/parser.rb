require 'yaml'

module SimpleHdGraph
  #
  # parse for YAML string
  #
  # :reek:InstanceVaariableAssumption
  class Parser
    KEYWORD_ID        ||= 'id'.freeze
    KEYWORD_RESOURCES ||= 'resources'.freeze
    KEYWORD_DEPENDS   ||= 'depends'.freeze

    #
    # @param document [String]
    #
    # :reek:TooManyStatements
    def parse(document)
      contexts = []

      YAML.load_stream(document) do |node|
        next unless node

        context   = nil
        resources = nil

        node.each_pair { |key, value|
          case key
          when KEYWORD_ID
            context = ContextNode.new
            context.load({ id: value })
          when KEYWORD_DEPENDS
          when KEYWORD_RESOURCES
            resources = value
          end
        }

        pack_resources_into_context(resources, context) if resources

        contexts << context
      end
      refill_relation(contexts)

      contexts
    end

    #
    # @param resources [Array]
    # @param context [ContextNode]
    #
    def pack_resources_into_context(resources, context)
      resources.each { |key, resource|
        rn = ResourceNode.new
        rn.load_with_context({ id: context.id }, { key => resource })
        context << rn
      }
    end

    #
    # @param contexts [Array]
    #
    def refill_relation(contexts)
      contexts.each {|context|
        context.refill_relation
      }
    end
  end
end
