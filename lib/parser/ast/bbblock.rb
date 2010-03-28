module BBos
  module Parser

    class BBBlock < Treetop::Runtime::SyntaxNode

      def accept(visitor)
        elements.map { |e| e.accept(visitor) }.join
      end

    end
    
  end
end