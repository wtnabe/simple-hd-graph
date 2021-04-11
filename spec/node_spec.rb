require 'spec_helper'

require 'yaml'

class TestingSingleRequiredFieldNode < SimpleHdGraph::Node
  required :name
end

class TestingMultipleRequiredFieldsNode < SimpleHdGraph::Node
  required :id, :name
end

def testing_single_required_valid_structure
  YAML.load(<<EOD, symbolize_names: true)
name: foo
EOD
end

def testing_multiple_required_valid_structure
  YAML.load(<<EOD, symbolize_names: true)
id: foo
name: bar
EOD
end

describe SimpleHdGraph::Node do
  describe '.required and #load' do
    describe 'no required fields' do
      it {
        assert {
          SimpleHdGraph::Node.new.load({})
        }
      }
    end

    describe 'single field' do
      before {
        @node = TestingSingleRequiredFieldNode.new
      }

      describe 'filled struct' do
        it 'valid' do
          assert { @node.load(testing_single_required_valid_structure) }
        end
      end

      describe 'empty' do
        it 'invalid' do
          assert {
            begin
              @node.load({})
            rescue SimpleHdGraph::Node::RequiredFieldNotFilled => e
              e.message == 'name'
            end
          }
        end
      end
    end

    describe 'multiple field' do
      before {
        @node = TestingMultipleRequiredFieldsNode.new
      }

      describe 'filled struct' do
        it 'valid' do
          assert {
            @node.load(testing_multiple_required_valid_structure)
          }
        end
      end

      describe 'empty' do
        it 'invalid' do
          assert {
            begin
              @node.load({})
            rescue SimpleHdGraph::Node::RequiredFieldNotFilled => e
              e.message == 'id'
            end
          }
        end
      end
    end
  end
end
