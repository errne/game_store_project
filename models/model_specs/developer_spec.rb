require('minitest/autorun')
require('minitest/rg')
require_relative('../developer')

class TestDeveloper < MiniTest::Test

  def setup
    options = {"name" => "Obsidian", "location" => "USA", "img_link" => "https://en.wikipedia.org/wiki/Blue_Byte#/media/File:UbisoftBlueByte.png",
      "id" => 1 }
    @developer1 = Developer.new(options)
  end

  def test_developer_has_name
    assert_equal("Obsidian", @developer1.name)
  end

  def test_developer_has_location
    assert_equal("USA", @developer1.location)
  end

  def test_can_find_developer_by_id
    assert_equal(@developer1.name, Developer.find(1).name)
  end

  def test_developer_has_img_link
    assert_equal("", @developer1.img_link)
  end

end
