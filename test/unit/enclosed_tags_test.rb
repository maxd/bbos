require File.join(File.dirname(__FILE__), "../test_helper.rb")

class EnclosedTagsTest < Test::Unit::TestCase

  context BBos::BBCode do

    setup do
      @bbcode = BBos::BBCode.new
    end

    should "process enclosed tags" do
      assert_equal "<b><b><b>Test</b></b></b>", @bbcode.to_html("[b][b][b]Test[/b][/b][/b]")
    end

    should "process enclosed tags #2" do
      assert_equal "<b>bar</b><b>baz</b>", @bbcode.to_html("[b]bar[/b][b]baz[/b]")
    end

  end
  
end