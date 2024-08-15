require "spec_helper"

describe SimpleHdGraph::Renderer::PlantUML::Resource do
  include ExampleLoader

  let(:parser) { SimpleHdGraph::Parser.new }
  let(:renderer) { SimpleHdGraph::Renderer::PlantUML::Resource.new }

  describe "#render" do
    before {
      @nodes = parser.parse(read_example(:simple))
    }

    it {
      puts renderer.render(@nodes.first.resources.first)
    }
  end
end
