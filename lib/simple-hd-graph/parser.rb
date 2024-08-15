require "yaml"

module SimpleHdGraph
  #
  # parse for YAML string
  #
  class Parser
    KEYWORD_ID = "id".freeze
    KEYWORD_RESOURCES = "resources".freeze
    KEYWORD_DEPENDS = "depends".freeze

    #
    # @param document [String]
    #
    def parse(document)
      contexts = []

      YAML.load_stream(document) do |node|
        next unless node

        context = nil
        resources = nil
        depends = nil

        node.each_pair { |key, value|
          case key
          when KEYWORD_ID
            context = ContextNode.new
            context.load({id: value})
          when KEYWORD_DEPENDS
            depends = value
          when KEYWORD_RESOURCES
            resources = value
          end
        }

        pack_depends_into_context(depends, context) if depends
        pack_resources_into_context(resources, context) if resources

        contexts << context
      end
      refill_relation(contexts)
      refill_depends(contexts)

      contexts.map { |context| context.freeze }.freeze
    end

    #
    # @param depends [Array]
    # @param context [ContextNode]
    #
    def pack_depends_into_context(depends, context)
      context.set_depends depends
    end

    #
    # @param resources [Array]
    # @param context [ContextNode]
    #
    def pack_resources_into_context(resources, context)
      resources.each { |key, resource|
        rn = ResourceNode.new
        rn.load_with_context({id: context.id}, {key => resource})
        context << rn
      }
    end

    #
    # @param contexts [Array]
    #
    def refill_relation(contexts)
      contexts.each { |context|
        context.refill_relation
      }
    end

    #
    # @param context [Array]
    #
    def refill_depends(contexts)
      contexts.map { |context|
        if context.depends
          regularized = context.depends.map { |dependee|
            d = contexts.find { |c|
              c.alias == dependee
            }

            {
              context.id => d ? d.id : dependee
            }
          }
          context.set_depends regularized
        else
          context.set_depends []
        end
      }
    end
  end
end
