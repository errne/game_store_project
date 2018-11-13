require( 'sinatra' )
require( 'sinatra/contrib/all' )
also_reload( '../models/*' )

get '/tools' do
  erb (:"tools/index" )
end
