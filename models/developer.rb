require_relative( '../db/sql_runner' )
require_relative('game')

class Developer
  attr_reader :name, :id, :location, :img_link

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @location = options['location']
    @img_link = options['img_link']
  end

  def save()
    sql = "INSERT INTO developers
    (
      name,
      location,
      img_link
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@name, @location, @img_link]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "UPDATE developers
    SET (name, location, img_link) =
    ($1, $2, $3)
    WHERE id = $4"
    values = [@name, @location, @img_link, @id]
    SqlRunner.run(sql, values)
  end

  def games()
    sql = "SELECT * FROM games
    WHERE developer_id = $1"
    values = [@id]
    results = SqlRunner.run( sql, values )
    return results.map { |game| Game.new(game) }
  end

  def self.all()
    sql = "SELECT * FROM developers"
    results = SqlRunner.run( sql )
    return results.map { |developer| Developer.new( developer ) }
  end

  def self.find( id )
    sql = "SELECT * FROM developers
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Developer.new( results.first )
  end

  def self.delete_all
    sql = "DELETE FROM developers"
    SqlRunner.run( sql )
  end

  def self.delete(id)
    sql = "DELETE FROM developers
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

end
