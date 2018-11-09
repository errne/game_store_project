require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative( 'controllers/developers_controller')

get '/' do
  erb( :index )
end
