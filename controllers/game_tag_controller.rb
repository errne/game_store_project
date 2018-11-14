require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/game_tag.rb' )
also_reload( '../models/*' )

get '/gametags' do
  @tags = GameTag.all()
  erb (:"gameTags/index" )
end

get '/gameTags/:id/new' do
  @game = Game.find(params['id'])
  @tags = Tag.all
  erb(:"gameTags/new")
end

post '/gameTags/:id/edit' do
  params["tag_id"].each do |id|
    GameTag.new({"game_id" => params[:game_id], "tag_id" => id}).save
  end
  redirect to '/gameTags/' + params[:game_id] + '/edit'
end

get '/gameTags/:id/edit' do
  @game = Game.find(params['id'])
  @gameTag = GameTag.all_by_game(params['id'])
  erb(:"gameTags/edit")
end

post '/gameTags/:id' do
  GameTag.new(params).save
  redirect to '/gameTags/' + params['id']
end

post '/gameTags/:id/:game_id/delete' do
  GameTag.delete(params[:id])
  redirect to '/gameTags/' + params[:game_id] + '/edit'
end
