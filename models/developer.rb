require_relative( '../db/sql_runner' )

class Developer
  attr_reader :name, :id, :location

def initialize(options)
  @id = options['id'].to_i if options['id']
  @name = options['name']
  @location = options['location']
end

def save()
  sql = "INSERT INTO developers
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

end
