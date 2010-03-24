require File.join(File.dirname(__FILE__), "../test_helper.rb")

class CommonFunctionalityTest < Test::Unit::TestCase

  context BBos::BBCode do

    setup do
      @bbcode = BBos::BBCode.new
    end

    should "throw ArgumentError exception then 'text' argument is nil" do
      assert_raise ArgumentError do
        @bbcode.to_html(nil)
      end
    end

    should "process empty string and return empty string" do
      assert_equal "", @bbcode.to_html("")
    end

    should "process whitespaces and return whitespaces" do
      assert_equal " \t \t ", @bbcode.to_html(" \t \t ")
    end

    should "process English chars" do
      assert_equal "English Test", @bbcode.to_html("English Test")
    end

    should "process Russian chars" do
      assert_equal "Тест на русском", @bbcode.to_html("Тест на русском")
    end

    should "process any special chars in string" do
      assert_equal %Q(<a href="][%20%09/">Test</a>), @bbcode.to_html(%Q([url="][ \t/"]Test[/url]))
    end

    should "process escaped quote in string" do
      assert_equal %q(<a href="%22">Test</a>), @bbcode.to_html(%q([url="\""]Test[/url]))
    end

    should "process escaped brackets in CHARS" do
      assert_equal %q(<a href="http://ya.ru">][</a>), @bbcode.to_html(%q([url=http://ya.ru]\]\[[/url]))
    end

    should "process escaped brackets in CHARS #2" do
      assert_equal %q(<a href="http://ya.ru">[/</a>), @bbcode.to_html(%q([url=http://ya.ru]\[/[/url]))
    end

    should "process escaped brackets in CHARS #3" do
      assert_equal %q(<a href="http://ya.ru">\</a>), @bbcode.to_html(%q([url=http://ya.ru]\\\\[/url]))
    end

    should "process escaped brackets in CHARS #4" do
      assert_equal %q(<a href="http://ya.ru"> \ </a>), @bbcode.to_html(%q([url=http://ya.ru] \\ [/url]))
    end

    should "process unknown tag and return error message #1" do
      assert_equal %Q(<span style="color:red">[Unknown tag 'unknown']</span>), @bbcode.to_html(%Q([unknown][/unknown]))
    end

    should "process unknown tag and return error message #2" do
      assert_equal %Q(<span style="color:red">[Unknown tag 'unknown']</span>), @bbcode.to_html(%Q([unknown]Text[/unknown]))
    end

    should "process unknown tag and return error message #3" do
      assert_equal %Q(<span style="color:red">[Unknown tag 'unknown']</span>), @bbcode.to_html(%Q([unknown/]))
    end

  end
end