require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/game.rb' )
require_relative('../models/game_tag.rb')
also_reload( '../models/*' )

get '/games' do
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
  GameTag.new({"game_id" => game, "tag_id" => params["tag_id"]}).save
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

post '/games/:id' do
  game = Game.new(params)
  game.update
  redirect to '/games/' + params['id']
end

post '/games/:id/delete' do
  Game.delete(params[:id])
  redirect to("/games")
end
