require File.join(File.dirname(__FILE__), "../test_helper.rb")

class UrlTagTest < Test::Unit::TestCase

  context BBos::BBCode do

    setup do
      @bbcode = BBos::BBCode.new
    end

    should "process url tag with URL" do
      assert_equal "<a href=\"http://ya.ru\">http://ya.ru</a>", @bbcode.to_html("[url=http://ya.ru][/url]")
    end

    should "process url tag with URL (as string)" do
      assert_equal "<a href=\"http://ya.ru\">http://ya.ru</a>", @bbcode.to_html("[url=\"http://ya.ru\"][/url]")
    end

    should "process url tag with content only" do
      assert_equal "<a href=\"http://ya.ru\">http://ya.ru</a>", @bbcode.to_html("[url]http://ya.ru[/url]")
    end

    should "process url tag with URL and content" do
      assert_equal "<a href=\"http://ya.ru\">Yandex</a>", @bbcode.to_html("[url=http://ya.ru]Yandex[/url]")
    end

    should "process url tag with URL (as string) and content" do
      assert_equal "<a href=\"http://ya.ru\">Yandex</a>", @bbcode.to_html("[url=\"http://ya.ru\"]Yandex[/url]")
    end

    should "process empty url tag #1" do
      assert_equal "", @bbcode.to_html("[url][/url]")
    end

    should "process empty url tag #2" do
      assert_equal "", @bbcode.to_html("[url/]")
    end

    should "process empty url tag #2 with URL" do
      assert_equal "<a href=\"http://ya.ru\">http://ya.ru</a>", @bbcode.to_html("[url=http://ya.ru/]")
    end

    should "process empty url tag #2 with URL (as string)" do
      assert_equal "<a href=\"http://ya.ru\">http://ya.ru</a>", @bbcode.to_html("[url=\"http://ya.ru\"/]")
    end

  end
end