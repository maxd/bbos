module BBos
  module Parser

    class BBDocument < Treetop::Runtime::SyntaxNode

      def accept(visitor)
        elements.map do |e|
          content = e.__block.elements.map { |be| be.accept(visitor) }.join
          visitor.bbblock(content)
        end.join
      end

    end
    
  end
end