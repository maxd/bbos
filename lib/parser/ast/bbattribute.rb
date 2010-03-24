module BBos
  module Parser

    class BBAttribute < Treetop::Runtime::SyntaxNode

      def value
        name = __name.text_value
        value = __value.respond_to?(:__string) ? __value.__string.value : nil

        Attribute.new(name, value)
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