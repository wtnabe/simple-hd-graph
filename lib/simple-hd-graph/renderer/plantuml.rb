Dir.glob(File.join(__dir__, "plantuml/*.rb")).sort.each { |f| require f }

module SimpleHdGraph
  module Renderer
    #
    # @param nodes [Array]
    #
    def plantuml(nodes)
      context = self::PlantUML::Context.new
      puts nodes.map { |node|
        context.render(node)
      }.join
    end
    module_function :plantuml
  end
end
