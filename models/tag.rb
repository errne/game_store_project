require_relative( '../db/sql_runner' )

class Tag
  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO tags
    ( name ) VALUES ( $1 )
    RETURNING id"
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "UPDATE tags
    SET
    ( name ) = ( $1 )
    WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run( sql, values )
  end

  def games()
    sql = "SELECT games.*
    FROM games
    INNER JOIN games_tags
    ON games_tags.game_id = games.id
    WHERE tag_id = $1"
    values = [@id]
    games = SqlRunner.run(sql, values)
    return games.map { |game| Game.new(game) }
  end

  def self.all()
    sql = "SELECT * FROM tags"
    tags = SqlRunner.run( sql )
    return tags.map { |tag| Tag.new( tag ) }
  end

  def self.find(id)
    sql = "SELECT * FROM tags
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Tag.new( results.first )
  end

  def self.delete_all
    sql = "DELETE FROM tags"
    SqlRunner.run( sql )
  end

  def self.delete(id)
    sql = "DELETE FROM tags
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

end
