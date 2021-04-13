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
        # :reek:FeatureEnvy
        def render(node)
          resources = node.resources.map { |resource|
            indent_resource(resource)
          }.join
          <<EOD
rectangle \"#{node.alias}\" as #{node.id} {
#{resources}
}
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
      end
    end
  end
end
