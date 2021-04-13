require 'spec_helper'

describe SimpleHdGraph::ContextNode do
  before {
    @node = SimpleHdGraph::ContextNode.new
  }

  describe '#alias' do
    describe 'small letter only' do
      it {
        @node.load({ id: 'foo' })
        assert {
          @node.id == 'foo'
        }
      }
    end

    describe 'has white space' do
      it {
        @node.load({ id: 'foo bar' })
        assert {
          @node.id == 'fooBar'
        }
      }
    end
  end
end
