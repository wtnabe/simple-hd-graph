require 'spec_helper'

describe SimpleHdGraph::Parser do
  include ExampleLoader

  let(:parser) { SimpleHdGraph::Parser.new }

  describe '#parse' do
    describe 'simple' do
      before {
        @nodes = parser.parse(read_example(:simple))
      }

      it 'context' do
        assert {
          @nodes.all? { |context|
            context.class == SimpleHdGraph::ContextNode
          }
        }
      end

      it 'context id' do
        assert {
          @nodes.first.id == 'simple'
        }
      end

      it 'resource' do
        assert {
          @nodes.all? { |context|
            context.resources.all? { |resource|
              resource.class == SimpleHdGraph::ResourceNode
            }
          }
        }
      end
    end

    describe 'complex' do
      before {
        @nodes = parser.parse(read_example(:complex))
      }

      it 'relations' do
        assert {
          @nodes.first.relations == [
            { 'example1Web' => 'example1Admin' },
            { 'example1Web' => 'example1Storage' }
          ]
        }
      end
    end

    describe 'depends' do
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
          @nodes.map { |node| node.depends } == [[], [{'example2' => 'example1'}]]
        }
      }
    end
  end
end
