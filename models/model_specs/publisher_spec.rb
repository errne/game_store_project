require('minitest/autorun')
require('minitest/rg')
require_relative('../publisher')

class TestPublisher < MiniTest::Test

  def setup
    options = {"name" => "Bethesda", "location" => "USA" }
    @publisher1 = Publisher.new(options)
  end

  def test_publisher_has_name
    assert_equal("Bethesda", @publisher1.name)
  end

  def test_publisher_has_location
    assert_equal("USA", @publisher1.location)
  end

end
