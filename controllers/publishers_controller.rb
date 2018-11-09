require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/publisher.rb' )
also_reload( '../models/*' )

get '/publishers' do
  @publishers = Publisher.all()
  erb ( :"publishers/index" )
end

get '/publishers/new' do
  erb(:"publishers/new")
end

post '/publishers' do
  Publisher.new(params).save
  redirect to '/publishers'
end

get '/publishers/:id' do
  @publisher = Publisher.find(params['id'].to_i)
  erb( :"publishers/show" )
end

get '/publishers/:id/edit' do
  @publisher = Publisher.find(params['id'])
  erb(:"publishers/edit")
end

post '/publishers/:id' do
  publisher = Publisher.new( params )
  publisher.update
  redirect to ("/publishers/#{params[:id]}")
end

post '/publishers/:id/delete' do
  Publisher.delete(params[:id])
  redirect to ("/publishers")
end
