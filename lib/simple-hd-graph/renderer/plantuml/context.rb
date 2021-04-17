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
        # :reek:FeatureEnvy, :reek:DuplicateMethodCall
        def render(node)
          resources = node.resources.map { |resource|
            indent_resource(resource)
          }.join if node.resources.size > 0
          relations = node.relations.map { |relation|
            render_relation(relation)
          }.join("\n") if node.relations.size > 0
          depends = node.depends.map { |depending|
            render_depends(depending)
          }.join("\n") if node.depends.size > 0
          (<<-EOD).gsub(/^$\n/, '')
rectangle \"#{node.alias}\" as #{node.id} {
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
