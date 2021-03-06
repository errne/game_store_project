require_relative( '../db/sql_runner' )
class Tagging

  attr_reader :id, :game_id, :tag_id

def initialize(options)
  @id = options['id'].to_i if options['id']
  @game_id = options['game_id']
  @tag_id = options['tag_id']
end

def save()
    sql = "INSERT INTO taggings
    (
      game_id,
      tag_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@game_id, @tag_id]
    visit = SqlRunner.run( sql,values ).first
    @id = visit['id'].to_i
  end

  def self.find( id )
    sql = "SELECT * FROM taggings
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Tagging.new( results.first )
  end

  def self.delete_by_game(game_id)
    sql = "DELETE FROM taggings
    WHERE game_id = $1"
    values = [game_id]
    SqlRunner.run( sql, values )
  end

  def self.delete_by_game_and_tag(game_id, tag_id)
    sql = "DELETE FROM taggings
    WHERE game_id = $1 AND tag_id = $2"
    values = [game_id, tag_id]
    SqlRunner.run( sql, values )
  end

  def self.all()
    sql = "SELECT * FROM taggings"
    visits = SqlRunner.run(sql)
    result = visits.map { |tagging| Tagging.new( tagging ) }
    return result
  end

  def self.all_by_game(game_id)
    sql = "SELECT * FROM taggings
    WHERE game_id = $1"
    values = [game_id]
    visits = SqlRunner.run(sql, values)
    result = visits.map { |tagging| Tagging.new( tagging ) }
    return result
  end

  def self.delete(id)
    sql = "DELETE FROM taggings
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

  def self.delete_all()
    sql = "DELETE FROM taggings"
    SqlRunner.run(sql)
  end

  def game()
    sql = "SELECT * FROM games
    WHERE id = $1"
    values = [@game_id]
    location = SqlRunner.run(sql, values).first
    return Game.new(location)
  end

  def tag()
    sql = "SELECT * FROM tags
    WHERE id = $1"
    values = [@tag_id]
    user = SqlRunner.run(sql, values).first
    return Tag.new(user)
  end

end
