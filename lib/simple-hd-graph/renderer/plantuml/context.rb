module SimpleHdGraph
  module Renderer
    module PlantUML
      class Context
        def initialize
          @resource_renderer = Resource.new
        end

        #
        # @param node [ContextNode]
        #
        def render(node)
          resources =
            if node.resources.size > 0
              node.resources.map { |resource|
                indent_resource(resource)
              }.join
            end
          relations =
            if node.relations.size > 0
              node.relations.map { |relation|
                render_relation(relation)
              }.join("\n")
            end
          depends =
            if node.depends.size > 0
              node.depends.map { |depending|
                render_depends(depending)
              }.join("\n")
            end

          <<~EOD.gsub(/^$\n/, "")
            rectangle "#{node.alias}" as #{node.id} {
            #{resources}
            #{relations}
            }
            #{depends}
          EOD
        end

        #
        # @param resource [String]
        # @return [String]
        #
        def indent_resource(resource)
          @resource_renderer.render(resource).lines.map { |line|
            "  #{line}"
          }.join
        end

        #
        # @param relation [Hash]
        # @return [String]
        #
        # :reek:UtilityFunction
        def render_relation(relation)
          depender, dependee = relation.to_a.first
          "  #{depender} -d-|> #{dependee}"
        end

        #
        # @param depending [Hash]
        # @return [String]
        #
        # :reek:UtilityFunction
        def render_depends(depending)
          depender, dependee = depending.to_a.first
          "#{depender} -|> #{dependee}"
        end
      end
    end
  end
end
