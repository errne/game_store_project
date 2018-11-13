require('minitest/autorun')
require('minitest/rg')
require_relative('../game')

class TestGame < MiniTest::Test

  def setup

    game_options = {"name" => "Skyrim", "developer_id" => 1, "publisher_id" => 1,
      "year" => 2011, "description" => "an interesting open world game",
      "stock_quantity" => 9, "buying_cost" => 25,
      "selling_price" => 35 }
      @game1 = Game.new(game_options)
    end

    def test_game_has_name
      assert_equal("Skyrim", @game1.name)
    end

    def test_game_has_developer_and_publisher_id
      assert_equal(1, @game1.developer_id)
      assert_equal(1, @game1.publisher_id)
    end

    def test_game_has_description
      assert_equal("an interesting open world game", @game1.description)
    end

    def test_game_has_stock_quantity_and_buying_selling_prices
      assert_equal(9, @game1.stock_quantity)
      assert_equal(25, @game1.buying_cost)
      assert_equal(35, @game1.selling_price)
    end

    def test_game_returns_markup
      assert_equal(10, @game1.get_markup)
    end

    def test_find_game_in_db_by_id
      assert_equal("Fallout: New Vegas", Game.find(1).name)
    end

    def test_game_returns_developer_and_publisher_name
      assert_equal("Obsidian", @game1.developer.name)
      assert_equal("Bethesda", @game1.publisher.name)
    end

    def test_game_returns_all_tags
      assert_equal([], @game1.tags)
    end

    def test_game_has_year
      assert_equal(2011, @game1.year)
    end

  end
