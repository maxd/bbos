module BBos
  module Parser

    class BBMarkup < Treetop::Runtime::SyntaxNode

      def accept(visitor)
        elements.map {|e| e.is_a?(String) ? e : e.accept(visitor) }.join
      end

    end
    
  end
end