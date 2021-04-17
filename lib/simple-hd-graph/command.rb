require 'optparse'

module SimpleHdGraph
  class Error < StandardError; end
  class FileNotExist < Error; end
  class DirectoryNotExist < Error; end

  class Command
    #
    # @param argv [Array]
    #
    def run(argv)
      parse(argv)
      if @file || @dir
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
      stream = if (@dir)
                 reader.read_dir(@dir)
               else
                 reader.read_file(@file)
               end

      nodes = parser.parse(stream)

      puts nodes.map { |node|
        renderer.render(node)
      }.join
    end

    #
    # @return [OptionParser]
    #
    # :reek:NestedIterators, :reek:DuplicateMethodCall
    def opts
      OptionParser.new do |opt|
        opt.on('-d DIR', '--dir', 'dirname') { |value|
          if File.exist?(value) && File.directory?(value)
            @dir = value
          else
            raise DirectoryNotExist, value
          end
        }
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
