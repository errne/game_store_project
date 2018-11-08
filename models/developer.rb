require_relative( '../db/sql_runner' )

class Developer
  attr_reader :name, :id, :location

def initialize(options)
  @id = options['id'].to_i if options['id']
  @name = options['name']
  @location = options['location']
end


end
