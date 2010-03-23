module BBos
  module Parser

    class BBAttribute < Treetop::Runtime::SyntaxNode

      def value
        #TODO: fix hack with rescue
        Attribute.new(__name.text_value, (__value.__string.value rescue nil))
      end

    end

    class Attribute

      attr_reader :name, :value

      def initialize(name, value)
        @name = name
        @value = value
      end

      def to_s
        "#{name}=#{value}"
      end

    end
    
  end
end