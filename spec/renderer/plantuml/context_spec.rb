require 'spec_helper'

describe SimpleHdGraph::Renderer::PlantUML::Context do
  include ExampleLoader

  let(:parser) { SimpleHdGraph::Parser.new }
  let(:renderer) { SimpleHdGraph::Renderer::PlantUML::Context.new }

  describe '#render' do
    before {
      @nodes = parser.parse(read_example(:simple))
    }

    it {
      puts renderer.render(@nodes.first)
    }
  end
end
