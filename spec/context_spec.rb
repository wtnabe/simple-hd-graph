require 'spec_helper'

describe SimpleHdGraph::ContextNode do
  before {
    @node = SimpleHdGraph::ContextNode.new
  }

  describe '#id' do
    it {
      @node.load({ id: 'foo' })
      assert {
        @node.id == 'foo'
      }
    }
  end
end
