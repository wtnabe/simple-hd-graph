module SimpleHdGraph
  class Node
    class RequiredFieldNotFilled < StandardError; end
    
    class << self
      #
      # @param names [Array]
      #
      def required(*names)
        @required_fields = names
      end
    end

    #
    # @param struct [Hash]
    #
    def load(struct)
      required_fields = if self.class.instance_variables.grep(':@required_fields').size > 0
                          self.class.instance_variable_get('@required_fields')
                        else
                          nil
                        end

      if required_fields.is_a? Array
        filled = required_fields.all? {|field|
          if struct.has_key? field
            true
          else
            raise RequiredFieldNotFilled, field
          end
        }
      else
        filled = true
      end

      @content = struct if filled
    end
  end
end
