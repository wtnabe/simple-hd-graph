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
          relations = node.relations.map { |relation|
            render_relation(relation)
          }.join("\n")
          <<EOD
rectangle \"#{node.alias}\" as #{node.id} {
#{resources}
#{relations if relations.size > 0}
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

        #
        # @param relation [Hash]
        # @return [String]
        #
        # :reek:UtilityFunction
        def render_relation(relation)
          depender, dependee = relation.to_a.first
          "  #{depender} -d-|> #{dependee}"
        end
      end
    end
  end
end
