require File.join(File.dirname(__FILE__), "../test_helper.rb")

class TextStyleTagsTest < Test::Unit::TestCase

  context BBos::BBCode do

    setup do
      @bbcode = BBos::BBCode.new
    end

    { 'b' => 'b',
      'i' => 'i',
      'u' => 'u',
      's' => 's' }.each do |tag, html_tag|

      should "process empty #{tag.upcase} tag #1" do
        assert_equal "", @bbcode.to_html("[#{tag}][/#{tag}]")
      end

      should "process empty #{tag.upcase} tag #2" do
        assert_equal "", @bbcode.to_html("[#{tag}/]")
      end

      should "process #{tag.upcase} tag #1" do
        assert_equal "<#{html_tag}>Text</#{html_tag}>", @bbcode.to_html("[#{tag}]Text[/#{tag}]")
      end

      should "process #{tag.upcase} tag #2" do
        assert_equal "<#{html_tag}>Text</#{html_tag}>", @bbcode.to_html("[#{tag}=Text][/#{tag}]")
      end

      should "process #{tag.upcase} tag #3" do
        assert_equal "<#{html_tag}>Text</#{html_tag}>", @bbcode.to_html("[#{tag}=Text/]")
      end

    end

  end
end