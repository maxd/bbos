module BBos
  module Parser

    class BBAttributeValue < Treetop::Runtime::SyntaxNode

      def value
        respond_to?(:__content) ? unescape(__content.text_value) : text_value
      end

    private

      def unescape(str)
        str.gsub("\\\\", "\\").gsub("\\\"", "\"")
      end
      
    end

  end
end