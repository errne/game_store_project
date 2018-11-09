require('minitest/autorun')
require('minitest/rg')
require_relative('../publisher')

class TestPublisher < MiniTest::Test

  def setup
    options = {"name" => "Bethesda", "location" => "USA", "id" => 1 }
    @publisher1 = Publisher.new(options)
  end

  def test_publisher_has_name
    assert_equal("Bethesda", @publisher1.name)
  end

  def test_publisher_has_location
    assert_equal("USA", @publisher1.location)
  end

  def test_can_find_publsiher_by_id
    assert_equal("Bethesda", Publisher.find(1).name)
  end

  def test_publisher_returns_all_published_games
    assert_equal("New Vegas", @publisher1.games[0].name)
  end
end
