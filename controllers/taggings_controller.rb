
require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/tagging.rb' )
also_reload( '../models/*' )

get '/taggings' do
  @tags = Tagging.all()
  erb (:"taggings/index" )
end

get '/taggings/:id/new' do
  @game = Game.find(params['id'])
  @tags = Tag.all
  erb(:"taggings/new")
end

post '/taggings/:id/edit' do
  params["tag_id"].each do |id|
    Tagging.new({"game_id" => params[:game_id], "tag_id" => id}).save
  end
  redirect to '/taggings/' + params[:game_id] + '/edit'
end

get '/taggings/:id/edit' do
  @game = Game.find(params['id'])
  @gameTag = Tagging.all_by_game(params['id'])
  erb(:"taggings/edit")
end

post '/taggings/:id' do
  Tagging.new(params).save
  redirect to '/taggings/' + params['id']
end

post '/taggings/:id/:game_id/delete' do
  Tagging.delete(params[:id])
  redirect to '/taggings/' + params[:game_id] + '/edit'
end
