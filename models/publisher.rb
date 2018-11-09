require_relative( '../db/sql_runner' )
require_relative('game')

class Publisher

  attr_reader :name, :id, :location

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @location = options['location']
  end

  def save()
    sql = "INSERT INTO publishers
    (
      name,
      location
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name, @location]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def games()
    sql = "SELECT * FROM games
    WHERE publisher_id = $1"
    values = [@id]
    results = SqlRunner.run( sql, values )
    return results.map { |game| Game.new(game) }
  end

  def self.all()
    sql = "SELECT * FROM publishers"
    results = SqlRunner.run( sql )
    return results.map { |publisher| Publisher.new( publisher ) }
  end

  def self.find(id)
    sql = "SELECT * FROM publishers
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Publisher.new( results.first )
  end

  def self.delete_all
    sql = "DELETE FROM publishers"
    SqlRunner.run( sql )
  end

end
