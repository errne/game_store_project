require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/game.rb' )
require_relative('../models/game_tag.rb')
also_reload( '../models/*' )

get '/games' do
  params["sort_by"]
  @games = Game.all()
  erb ( :"games/index" )
end

get '/games/new' do
  @developers = Developer.all
  @publishers = Publisher.all
  @tags = Tag.all
  erb(:"games/new")
end

post '/games' do
  game = Game.new(params).save
  params["tag_id"].each do |id|
    GameTag.new({"game_id" => game, "tag_id" => id}).save
  end
  redirect to '/games'
end

get '/games/:id' do
  @game = Game.find(params['id'].to_i)
  erb( :"games/show" )
end

get '/games/:id/edit' do
  @developers = Developer.all
  @publishers = Publisher.all
  @game = Game.find(params['id'])
  erb(:"games/edit")
end

get '/games/:id/edit/tags' do
  @tags = Tag.all
  @game = Game.find(params['id'])
  erb(:"games/editTags")
end

post '/games/:id/edit/tags' do
  # GameTag.delete(params[:id])
  # gt = GameTag.new(params)
  # gt.save
  params["tag_id"].each do |id|
    GameTag.new({"game_id" => params['game_id'], "tag_id" => id}).save
  end
  redirect to 'games/' + params['id'] + '/edit/tags'
end

post '/games/:id' do
  game = Game.new(params)
  game.update
  redirect to '/games/' + params['id']
end

post '/games/:id/delete' do
  GameTag.delete_by_game(params[:id])
  Game.delete(params[:id])
  redirect to("/games")
end

get '/games/sorted/by/year' do
  @games = Game.all_by_year()
  erb ( :"games/index" )
end

get '/games/sorted/by/namez' do
  @games = Game.all_by_name__desc()
  erb ( :"games/index" )
end

get '/games/sorted/by/low-stock' do
  @games = Game.all_low_stock()
  erb ( :"games/index" )
end

get '/games/sorted/by/price' do
  @games = Game.all_by_selling_price_desc()
  erb ( :"games/index" )
end

get '/games/sorted/by/cost' do
@games = Game.all_by_buying_cost_desc()
erb ( :"games/index" )
end

get '/games/sorted/by/stock' do
@games = Game.all_by_stock_quantity()
erb ( :"games/index" )
end

get '/games/sorted/by/:id' do
  @games = Game.find_all_by_tag(params[:id])
  erb ( :"games/index" )
end
