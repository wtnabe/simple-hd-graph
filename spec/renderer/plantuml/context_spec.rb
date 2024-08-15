require "spec_helper"

describe SimpleHdGraph::Renderer::PlantUML::Context do
  include ExampleLoader

  let(:parser) { SimpleHdGraph::Parser.new }
  let(:renderer) { SimpleHdGraph::Renderer::PlantUML::Context.new }

  describe "#render" do
    describe "simple" do
      before {
        @nodes = parser.parse(read_example(:simple))
      }

      it {
        assert {
          renderer.render(@nodes.first)
        }
      }
    end

    describe "complex" do
      before {
        @nodes = parser.parse(read_example(:complex))
      }

      it {
        assert {
          renderer.render(@nodes.first)
        }
      }
    end

    describe "depends" do
      before {
        @nodes = parser.parse(
          [
            read_example(:complex),
            read_example(:depending)
          ].join("---\n")
        )
      }

      it {
        assert {
          @nodes.map { |node|
            renderer.render(node)
          }
        }
      }
    end
  end
end
