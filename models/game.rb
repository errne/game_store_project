require_relative( '../db/sql_runner' )
require_relative('developer')
require_relative('publisher')
require_relative('tag')


class Game

  attr_reader :id, :name, :developer_id, :publisher_id, :year, :description, :stock_quantity,
  :buying_cost, :selling_price


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @developer_id = options['developer_id'].to_i
    @publisher_id = options['publisher_id'].to_i
    @year = options['year'].to_i
    @description = options['description']
    @stock_quantity = options['stock_quantity'].to_i
    @buying_cost = options['buying_cost'].to_i
    @selling_price = options['selling_price'].to_i
  end

  def get_markup()
    return @selling_price - @buying_cost
  end

  def developer()
    developer = Developer.find(@developer_id)
    return developer
  end

  def publisher()
    publisher = Publisher.find(@publisher_id)
    return  publisher
  end

  def save()
    sql = "INSERT INTO games
    (
      name,
      developer_id,
      publisher_id,
      year,
      description,
      stock_quantity,
      buying_cost,
      selling_price
    )
    VALUES
    (
      $1, $2, $3, $4, $5, $6, $7, $8
    )
    RETURNING id"
    values = [@name, @developer_id, @publisher_id, @year, @description, @stock_quantity,
      @buying_cost, @selling_price]
      results = SqlRunner.run(sql, values)
      @id = results.first()['id'].to_i
    end

    def update()
      sql = "UPDATE games
      SET
      (
        name,
        developer_id,
        publisher_id,
        year,
        description,
        stock_quantity,
        buying_cost,
        selling_price
        ) =
        (
          $1, $2, $3, $4, $5, $6, $7, $8
        )
        WHERE id = $9"
        values = [@name, @developer_id, @publisher_id, @year, @description, @stock_quantity,
          @buying_cost, @selling_price, @id]
          SqlRunner.run( sql, values )
        end

        def tags()
          sql = "SELECT tags.*
          FROM tags
          INNER JOIN taggings
          ON taggings.tag_id = tags.id
          WHERE game_id = $1"
          values = [@id]
          tags = SqlRunner.run(sql, values)
          return tags.map { |tag| Tag.new(tag) }
        end

        def stock_level()
          return " low stock" unless @stock_quantity > 5
        end

        def self.all()
          sql = "SELECT * FROM games ORDER BY name ASC;"
          results = SqlRunner.run( sql )
          return results.map { |game| Game.new( game ) }
        end

        def self.all_by_year()
          sql = "SELECT * FROM games ORDER BY year DESC;"
          results = SqlRunner.run( sql )
          return results.map { |game| Game.new( game ) }
        end

        def self.all_by_name__desc()
          sql = "SELECT * FROM games ORDER BY name DESC;"
          results = SqlRunner.run( sql )
          return results.map { |game| Game.new( game ) }
        end

        def self.all_by_selling_price_desc()
          sql = "SELECT * FROM games ORDER BY selling_price DESC;"
          results = SqlRunner.run( sql )
          return results.map { |game| Game.new( game ) }
        end

        def self.all_by_buying_cost_desc()
          sql = "SELECT * FROM games ORDER BY buying_cost ASC;"
          results = SqlRunner.run( sql )
          return results.map { |game| Game.new( game ) }
        end

        def self.all_by_stock_quantity()
          sql = "SELECT * FROM games ORDER BY stock_quantity ASC;"
          results = SqlRunner.run( sql )
          return results.map { |game| Game.new( game ) }
        end

        def self.all_stock_value()
          return Game.all.reduce(0) { |sum, game| sum + (game.buying_cost * game.stock_quantity) }
        end

        def self.all_stock_sale_value
          return Game.all.reduce(0) { |sum, game| sum + (game.selling_price * game.stock_quantity) }
        end

        def self.predicted_total_profits
          return Game.all_stock_sale_value - Game.all_stock_value
        end

        def self.all_low_stock()
          sql = "SELECT * FROM games
          WHERE stock_quantity < 5"
          results = SqlRunner.run( sql )
          return results.map { |game| Game.new( game ) }
        end

        def self.all_low_stock__custom(number)
          sql = "SELECT * FROM games
          WHERE stock_quantity < $1"
          values = number
          results = SqlRunner.run( sql, values )
          return results.map { |game| Game.new( game ) }
        end

        def self.find( id )
          sql = "SELECT * FROM games
          WHERE id = $1"
          values = [id]
          results = SqlRunner.run( sql, values )
          return Game.new( results.first )
        end

        def self.find_all_by_tag(tag_id)
          tag = Tag.find(tag_id)
          tag.games()
        end

        def self.delete_all
          sql = "DELETE FROM games"
          SqlRunner.run( sql )
        end

        def self.delete(id)
          sql = "DELETE FROM games
          WHERE id = $1"
          values = [id]
          SqlRunner.run( sql, values )
        end

      end
