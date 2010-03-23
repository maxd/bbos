require "rubygems"
require "treetop"
require File.join(File.dirname(__FILE__), "formatter", "html")
require File.join(File.dirname(__FILE__), "parser", "bbcode")

module BBos
  class BBCode

    STANDARD_BBCODES = %w(b i u s size color center quote url img ul ol li)
    VIDEO_BBCODES = %w(youtube gvideo)
    EXTENDED_BBCODES = %w(csv style h1 h2 h3 h4 h5 h6 h7)

    ALL_BBCODES = STANDARD_BBCODES + VIDEO_BBCODES + EXTENDED_BBCODES

    def initialize(avalible_bbcodes = ALL_BBCODES, options = {})
      @avalible_bbcodes = avalible_bbcodes
      @extensions = options.delete(:extensions) || []
      @parser = Parser::BBCodeParser.new
    end

    def to_html(text, options = {})
      raise ArgumentError.new("'text' argument can't be nil") if text.nil?
      return "" if text == ""

      ast = @parser.parse(text)

      if ast
        visitor = Formatter::Html.new(@avalible_bbcodes)
        @extensions.each { |ext| visitor.extend(ext) }
        ast.accept(visitor)
      else
        #TODO: convert failure_reason to HTML 
        @parser.failure_reason
      end
    end

  end
end