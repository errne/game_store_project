require('minitest/autorun')
require('minitest/rg')
require_relative('../genre')

class TestGenre < MiniTest::Test

  def setup
    options = {"name" => "RPG", "id" => 1 }
    @genre1 = Genre.new(options)
  end

  def test_genre_has_name
    assert_equal("RPG", @genre1.name )
  end

end
