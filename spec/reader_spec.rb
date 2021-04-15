require 'spec_helper'

describe SimpleHdGraph::Reader do
  describe '#read_dir' do
    it {
      reader = SimpleHdGraph::Reader.new
      assert {
        reader.read_dir(File.join(__dir__, 'support'))
      }
    }
  end
end
