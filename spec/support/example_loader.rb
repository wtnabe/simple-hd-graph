module ExampleLoader
  class ExampleNotFound < StandardError; end

  #
  # @param name [String]
  # @return String
  #
  def read_example(name)
    examples = Dir.glob(__dir__ + "/example_#{name}.{yml,yaml}")
    
    if examples.size > 0
      File.read(examples.first)
    else
      raise ExampleNotFound.new name
    end    
  end

  #
  # @param name [String]
  # @return Hash
  #
  def load_example(name)
    YAML.load(read_example(name), symbolize_names: true)
  end
end
