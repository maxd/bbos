module BBos
  module Parser

    class BBTag < Treetop::Runtime::SyntaxNode

      def accept(visitor)
        attributes = __attributes.elements.collect {|a| a.value }
        content = respond_to?(:__content) && __content.is_a?(BBBlock) ? __content.accept(visitor) : nil
        content = content == "" ? nil : content

        visitor.bbtag(attributes, content)
      end

    end

  end
end