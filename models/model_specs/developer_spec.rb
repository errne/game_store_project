require('minitest/autorun')
require('minitest/rg')
require_relative('../developer')

class TestDeveloper < MiniTest::Test

  def setup
    options = {"name" => "Bethesda", "location" => "USA" }
    @developer1 = Developer.new(options)
  end

  def test_developer_has_name
    assert_equal("Bethesda", @developer1.name)
  end

  def test_developer_has_location
    assert_equal("USA", @developer1.location)
  end

end
