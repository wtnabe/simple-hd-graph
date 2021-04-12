require 'spec_helper'

describe SimpleHdGraph::ResourceNode do
  # @return [Hash]
  def testing_context
    YAML.load(<<EOD, symbolize_names: true)
id: context
EOD
  end

  # @return [Hash]
  def testing_resource
    YAML.load(<<EOD, symbolize_names: true)
web:
  hosting: Heroku-16
  runtime: Ruby 2.5
EOD
  end

  before {
    context = SimpleHdGraph::ContextNode.new.load(testing_context)
    @node = SimpleHdGraph::ResourceNode.new(context)
    @node.load(testing_resource)
  }

  describe '#alias' do
    it {
      assert { @node.alias == 'web' }
    }
  end

  describe '#id' do
    it {
      assert { @node.id == 'contextWeb' }
    }
  end
end
