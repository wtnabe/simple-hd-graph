module SimpleHdGraph
  module Renderer
    module PlantUML
      class Resource
        #
        # @param node [ResourceNode]
        #
        # :reek:UtilityFunction
        def render(node)
          content = node.content.map { |key, value|
            "  #{key}: #{value}"
          }.join("\n")
          <<~EOD
            object "#{node.alias}" as #{node.id} {
            #{content}
            }
          EOD
        end
      end
    end
  end
end
