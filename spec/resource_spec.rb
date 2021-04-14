require 'spec_helper'

describe SimpleHdGraph::ResourceNode do
  include ExampleLoader

  let(:parser) { SimpleHdGraph::Parser.new }

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
    @node = SimpleHdGraph::ResourceNode.new
    @node.load_with_context(context, testing_resource)
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

  describe '#content' do
    it 'does not include `has`' do
      nodes = parser.parse(read_example(:complex))

      assert {
        nodes.first.resources.first.content == {
          'hosting' => 'Heroku',
          'runtime' => 'Ruby 2.5'
        }
      }
    end
  end

  describe '#has' do
    it {
      nodes = parser.parse(read_example(:complex))

      assert {
        nodes.first.resources.first.has == ['admin', 'storage']
      }
    }
  end
end
