require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/developer.rb' )
also_reload( '../models/*' )

get '/developers' do
  @developers = Developer.all()
  erb ( :"developers/index" )
end

get '/developers/new' do
  erb(:"developers/new")
end

post '/developers' do
  Developer.new(params).save
  redirect to '/developers'
end

get '/developers/:id' do
  @developer = Developer.find(params['id'].to_i)
  erb( :"developers/show" )
end

get '/developers/:id/edit' do
  @developer = Developer.find(params['id'])
  erb(:"developers/edit")
end

post '/developers/:id' do
  developer = Developer.new(params)
  developer.update
  redirect to '/developers/' + params['id']
end

post '/developers/:id/delete' do
  Developer.delete(params[:id])
  redirect to("/developers")
end
