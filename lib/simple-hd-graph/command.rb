require 'optparse'

module SimpleHdGraph
  class FileNotExist < StandardError; end

  class Command
    #
    # @param argv [Array]
    #
    def run(argv)
      parse(argv)
      if @file
        start
      end
    end

    #
    # @param argv [Array]
    #
    def parse(argv)
      opts.parse(argv)
    end

    #
    # @param parser [Parser]
    # @param reader [Reader]
    # @param renderer [Renderer]
    #
    def start(parser: Parser.new, reader: Reader.new, renderer: Renderer::PlantUML::Context.new)
      nodes = parser.parse(reader.read_file(@file))

      puts nodes.map { |node|
        renderer.render(node)
      }.join
    end

    #
    # @return [OptionParser]
    #
    # :reek:NestedIterators
    def opts
      OptionParser.new do |opt|
        opt.on('-f FILE', '--file', 'filename') { |value|
          if File.exist?(value) && File.file?(value)
            @file = value
          else
            raise FileNotExist, value
          end
        }
      end
    end
  end
end
