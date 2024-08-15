module SimpleHdGraph
  class Reader
    #
    # @param file [String]
    # @return [String]
    #
    def read_file(file)
      File.read(file)
    end

    #
    # @param dir [String]
    # @return [String]
    #
    def read_dir(dir)
      Dir.glob("#{dir}/**/*.{yml,yaml}").map { |file|
        read_file(file)
      }.join("---\n")
    end
  end
end
