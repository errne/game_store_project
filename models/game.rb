require_relative( '../db/sql_runner' )

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

end
