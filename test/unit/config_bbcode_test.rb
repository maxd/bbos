require File.join(File.dirname(__FILE__), "../test_helper.rb")

module BBCodeExtension
  include Test::Unit::Assertions 

  def newtag_bbtag(attributes, content)
    assert_equal 1, attributes.size
    assert_equal nil, attributes[0].value
    assert_equal "Test", content

    "<newtag/>"
  end

  def nil_bbtag(attributes, content)
    assert_equal 1, attributes.size
    assert_equal nil, attributes[0].value
    assert_equal "Test", content

    nil
  end

  def array_bbtag(attributes, content)
    assert_equal 1, attributes.size
    assert_equal nil, attributes[0].value
    assert_equal "Test", content

    []
  end

  def i_bbtag(attributes, content)
    assert_equal 1, attributes.size
    assert_equal nil, attributes[0].value
    assert_equal "Test", content

    "<itag/>"
  end

  def ec_bbtag(attributes, content)
    assert_nil content
    ""
  end

end

class ConfigBBCodeTest < Test::Unit::TestCase

  context BBos::BBCode do

    should "process only avalible attributes" do
      bbcode = BBos::BBCode.new(%w(b))
      assert_equal "<b>Test</b>", bbcode.to_html("[b]Test[/b]")
      assert_equal %Q(<span style="color:red">[Unknown tag 'u']</span>), bbcode.to_html("[u]Test[/u]")
    end

    should "process custom tags" do
      bbcode = BBos::BBCode.new(%w(newtag), :extensions => [BBCodeExtension])
      assert_equal "<newtag/>", bbcode.to_html("[newtag]Test[/newtag]")
    end

    should "process custom tags and return ONLY string value #1" do
      bbcode = BBos::BBCode.new(%w(nil), :extensions => [BBCodeExtension])
      assert_equal %q(<span style="color:red">[The method for custom tag 'nil' should return only string value]</span>), bbcode.to_html("[nil]Test[/nil]")
    end

    should "process custom tags and return ONLY string value #2" do
      bbcode = BBos::BBCode.new(%w(array), :extensions => [BBCodeExtension])
      assert_equal %q(<span style="color:red">[The method for custom tag 'array' should return only string value]</span>), bbcode.to_html("[array]Test[/array]")
    end

    should "process custom tags and pass correct content argument" do
      bbcode = BBos::BBCode.new(%w(ec), :extensions => [BBCodeExtension])
      assert_equal "", bbcode.to_html("[ec][/ec]")
    end

    should "process custom tags which can replace standard tags" do
      bbcode = BBos::BBCode.new(%w(i), :extensions => [BBCodeExtension])
      assert_equal "<itag/>", bbcode.to_html("[i]Test[/i]")
    end

  end

end