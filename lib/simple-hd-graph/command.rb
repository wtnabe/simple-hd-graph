require "optparse"

module SimpleHdGraph
  class FileNotExist < Error; end
  class DirectoryNotExist < Error; end # rubocop:disable Layout/EmptyLineBetweenDefs

  class Command
    #
    # @param parser [Parser]
    # @param reader [Reader]
    # @param renderer [Symbol]
    #
    def initialize(parser: Parser.new, reader: Reader.new, renderer: :plantuml)
      @parser = parser
      @reader = reader
      @renderer = SimpleHdGraph::Renderer.method(renderer.to_s)
    end
    attr_reader :parser, :reader, :renderer

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
    # @return [String]
    #
    def stream
      if @dir
        reader.read_dir(@dir)
      else
        reader.read_file(@file)
      end
    end

    def start
      nodes = parser.parse(stream)

      @renderer.call(nodes)
    end

    #
    # @return [OptionParser]
    #
    # :reek:NestedIterators, :reek:DuplicateMethodCall
    def opts
      OptionParser.new do |opt|
        opt.on("-d DIR", "--dir", "dirname") { |value|
          if File.exist?(value) && File.directory?(value)
            @dir = value
          else
            raise DirectoryNotExist, value
          end
        }
        opt.on("-f FILE", "--file", "filename") { |value|
          if File.exist?(value) && File.file?(value)
            @file = value
          else
            raise FileNotExist, value
          end
        }
        opt.on("-r RENDERER", "--renderer", "renderer") { |value|
          begin
            @renderer = SimpleHdGraph::Renderer.method(value)
          rescue NameError
            warn "[Warining] renderer `#{value}` not found. falling back to :plantuml"
          end
        }
      end
    end
  end
end
