module BBos
  module Parser

    class BBText < Treetop::Runtime::SyntaxNode

      def accept(visitor)
        visitor.bbtext(value)
      end

      def value
        unescape(text_value)
      end

    private

      def unescape(str)
        str.gsub("\\\\", "\\").gsub("\\[", "[").gsub("\\]", "]")
      end
      
    end

  end
end