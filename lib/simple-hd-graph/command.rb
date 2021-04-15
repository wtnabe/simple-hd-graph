require 'optparse'

module SimpleHdGraph
  class Command
    def initialize(argv)
      @argv = argv.dup
    end

    def run
      opts.parse(@argv)
      if @file
        nodes = Parser.new.parse(Reader.new.read_file(@file))
        renderer = Renderer::PlantUML::Context.new

        puts nodes.map { |node|
          renderer.render(node)
        }.join
      end
    end

    #
    # @return [OptionParser]
    #
    # :reek:NestedIterators
    def opts
      OptionParser.new do |opt|
        opt.on('-f FILE', '--file', 'filename') { |value|
          @file = value
        }
      end
    end
  end
end
