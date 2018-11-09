require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/game.rb' )
also_reload( '../models/*' )

get '/games' do
  @games = Game.all()
  erb ( :"games/index" )
end

get '/games/new' do
  @developers = Developer.all
  @publishers = Publisher.all
  erb(:"games/new")
end

post '/games' do
  Game.new(params).save
  redirect to '/games'
end

get '/games/:id' do
  @game = Game.find(params['id'].to_i)
  erb( :"games/show" )
end

post '/games/:id/delete' do
  Game.delete(params[:id])
  redirect to("/games")
end
