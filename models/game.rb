require_relative( '../db/sql_runner' )
require_relative('developer')
require_relative('publisher')
require_relative('tag')


class Game

  attr_reader :id, :name, :developer_id, :publisher_id, :description, :stock_quantity,
  :buying_cost, :selling_price


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @developer_id = options['developer_id'].to_i
    @publisher_id = options['publisher_id'].to_i
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
      description,
      stock_quantity,
      buying_cost,
      selling_price
    )
    VALUES
    (
      $1, $2, $3, $4, $5, $6, $7
    )
    RETURNING id"
    values = [@name, @developer_id, @publisher_id, @description, @stock_quantity,
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
        description,
        stock_quantity,
        buying_cost,
        selling_price
        ) =
        (
          $1, $2, $3, $4, $5, $6, $7
        )
        WHERE id = $8"
        values = [@name, @developer_id, @publisher_id, @description, @stock_quantity,
          @buying_cost, @selling_price, @id]
        SqlRunner.run( sql, values )
      end

      def tags()
        sql = "SELECT tags.*
        FROM tags
        INNER JOIN games_tags
        ON games_tags.tag_id = tags.id
        WHERE game_id = $1"
        values = [@id]
        tags = SqlRunner.run(sql, values)
        return tags.map { |tag| Tag.new(tag).name }
      end

    def self.all()
      sql = "SELECT * FROM games"
      results = SqlRunner.run( sql )
      return results.map { |game| Game.new( game ) }
    end

    def self.find( id )
      sql = "SELECT * FROM games
      WHERE id = $1"
      values = [id]
      results = SqlRunner.run( sql, values )
      return Game.new( results.first )
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
