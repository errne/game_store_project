require_relative( '../db/sql_runner' )
class GameTag
  attr_reader :id, :game_id, :tag_id

def initialize(options)
  @id = options['id'].to_i if options['id']
  @game_id = options['game_id']
  @tag_id = options['tag_id']
end

def save()
    sql = "INSERT INTO games_tags
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

  def self.delete_by_game(game_id)
    sql = "DELETE FROM games_tags
    WHERE game_id = $1"
    values = [game_id]
    SqlRunner.run( sql, values )
  end

  def self.delete_by_game_and_tag(game_id, tag_id)
    sql = "DELETE FROM games_tags
    WHERE game_id = $1 AND tag_id = $2"
    values = [game_id, tag_id]
    SqlRunner.run( sql, values )
  end

  def self.all()
    sql = "SELECT * FROM games_tags"
    visits = SqlRunner.run(sql)
    result = visits.map { |gameTag| GameTag.new( gameTag ) }
    return result
  end

  def self.delete(id)
    sql = "DELETE FROM games_tags
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

  def self.delete_all()
    sql = "DELETE FROM games_tags"
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
