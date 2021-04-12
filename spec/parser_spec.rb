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
  end
end
