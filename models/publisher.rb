require_relative( '../db/sql_runner' )

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

end
