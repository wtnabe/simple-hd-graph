require "spec_helper"

describe SimpleHdGraph::Command do
  def command
    @command ||= SimpleHdGraph::Command.new
  end

  describe "#parse" do
    describe "file" do
      describe "exists" do
        it {
          assert {
            command.parse(["-f", File.join(__dir__, "support/example_simple.yaml")])
          }
        }
      end

      describe "not exist" do
        it {
          assert_raises SimpleHdGraph::FileNotExist do
            command.parse(["-f", "notexist"])
          end
        }
      end
    end

    describe "dir" do
      describe "exists" do
        it {
          assert {
            command.parse(["-d", File.join(__dir__, "support")])
          }
        }
      end

      describe "not exist" do
        it {
          assert_raises SimpleHdGraph::DirectoryNotExist do
            command.parse(["-d", "notexist"])
          end
        }
      end
    end
  end
end
