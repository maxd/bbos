require File.join(File.dirname(__FILE__), "../test_helper.rb")

class BlockTest < Test::Unit::TestCase

  context BBos::BBCode do

    setup do
      @bbcode = BBos::BBCode.new
    end

    should "format paragraphs" do
      assert_equal "<p>Line1</p>", @bbcode.to_html("Line1", :paragraphs => true)
    end

    should "format paragraphs for several string" do
      assert_equal "<p>Line1</p><p>Line2</p>", @bbcode.to_html("Line1\n\nLine2", :paragraphs => true)
    end

    should "join lines separated by newline symbol" do
      assert_equal "<p>Line1\nLine2</p>", @bbcode.to_html("Line1\nLine2", :paragraphs => true)
    end

    should "format paragraphs for external block only (exclude blocks between start and end tags)" do
      assert_equal "<p><b>Line1</b></p>", @bbcode.to_html("[b]Line1[/b]", :paragraphs => true)
    end

  end
end