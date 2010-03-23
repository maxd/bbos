module BBos
  module Formatter

    class Html

      def initialize(avalible_bbcodes)
        @avalible_bbcodes = avalible_bbcodes
      end

      def bbtag(attributes, content)
        name = attributes.first.name
        method = :"#{name}_bbtag"
        if @avalible_bbcodes.include?(name) && self.respond_to?(method)
          result = self.send(method, attributes, content)

          unless result.is_a? String
            error_tag("The method for custom tag '#{name}' should return only string value")
          else
            result
          end
        else
          unknown_tag(attributes, content)
        end
      end

      def bbtext(text)
        text
      end

      def url_bbtag(attributes, content)
        first_attr = attributes.first
        if content || first_attr.value
          href = first_attr.value
          href = content unless href
          content = href unless content
          %Q(<a href="#{href}">#{content}</a>)
        else
          ""
        end
      end

      def b_bbtag(attributes, content)
        text_style("b", attributes, content)
      end

      def i_bbtag(attributes, content)
        text_style("i", attributes, content)
      end

      def u_bbtag(attributes, content)
        text_style("u", attributes, content)
      end

      def s_bbtag(attributes, content)
        text_style("s", attributes, content)
      end

      def size_bbtag(attributes, content)
        first_attr = attributes.first
        if content && first_attr.value
          size_value = Integer(first_attr.value) rescue 0
          if size_value > 0 and size_value < 72
            %Q(<span style="font-size:#{size_value}px">#{content}</span>)
          else
            error_tag("Incorrect '#{first_attr.name}' attribute in '#{first_attr.name}' tag")
          end
        else
          ""
        end
      end

    protected

      def error_tag(message)
        %Q(<span style="color:red">[#{message}]</span>)
      end

      def unknown_tag(attributes, content)
        first_attr = attributes.first
        error_tag("Unknown tag '#{first_attr.name}'")
      end

      def text_style(html_tag, attributes, content)
        first_attr = attributes.first
        if content || first_attr.value
          content = first_attr.value unless content
          %Q(<#{html_tag}>#{content}</#{html_tag}>)
        else
          ""
        end
      end


    end
    
  end
end