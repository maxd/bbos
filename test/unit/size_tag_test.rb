require File.join(File.dirname(__FILE__), "../test_helper.rb")

class SizeTagTest < Test::Unit::TestCase

  context BBos::BBCode do

    setup do
      @bbcode = BBos::BBCode.new
    end

    should "process empty size tag and return empty string #1" do
      assert_equal "", @bbcode.to_html(%q([size][/size]))
    end

    should "process empty size tag and return empty string #2" do
      assert_equal "", @bbcode.to_html(%q([size=16][/size]))
    end

    should "process empty size tag and return empty string #3" do
      assert_equal "", @bbcode.to_html(%q([size="16"][/size]))
    end

    should "process empty size tag and return empty string #4" do
      assert_equal "", @bbcode.to_html(%q([size/]))
    end

    should "process empty size tag and return empty string #5" do
      assert_equal "", @bbcode.to_html(%q([size=16/]))
    end

    should "process empty size tag and return empty string #6" do
      assert_equal "", @bbcode.to_html(%q([size="16"/]))
    end

    should "process size tag" do
      assert_equal %q(<span style="font-size:16px">Text</span>), @bbcode.to_html(%q([size=16]Text[/size]))
    end

    should "process size tag (as string)" do
      assert_equal %q(<span style="font-size:16px">Text</span>), @bbcode.to_html(%q([size="16"]Text[/size]))
    end

    should "process size tag with wrong size value #1" do
      assert_equal %q(<span style="color:red">[Incorrect 'size' attribute in 'size' tag]</span>), @bbcode.to_html(%q([size=zxcv]Text[/size]))
    end

    should "process size tag with wrong size value #2" do
      assert_equal %q(<span style="color:red">[Incorrect 'size' attribute in 'size' tag]</span>), @bbcode.to_html(%q([size=16zxcv]Text[/size]))
    end

    should "process size tag with wrong size value #3" do
      assert_equal %q(<span style="color:red">[Incorrect 'size' attribute in 'size' tag]</span>), @bbcode.to_html(%q([size=zxcv16zxcv]Text[/size]))
    end

  end
end