require "dry/inflector"

module SimpleHdGraph
  class Node
    class RequiredFieldNotFilled < Error; end

    class << self
      #
      # @param names [Array]
      #
      def required(*names)
        @required_fields = names
      end
    end

    CAMELIZE_SEPARATOR = /[ ,.、。]/

    def initialize
      @inflector = Dry::Inflector.new
    end

    #
    # @param struct [Hash]
    #
    def load(struct)
      klass = self.class

      required_fields =
        if klass.instance_variables.grep(/@required_fields/).size > 0
          klass.instance_variable_get(:@required_fields)
        end

      filled =
        if required_fields.is_a? Array
          required_fields.all? { |field|
            if struct.has_key? field
              true
            else
              raise RequiredFieldNotFilled, field
            end
          }
        else
          true
        end

      @content = struct if filled
    end

    #
    # @param str [String]
    # @return [String]
    #
    def camelize(str)
      @inflector.camelize(@inflector.underscore(str.gsub(CAMELIZE_SEPARATOR, "_")))
    end
  end
end
