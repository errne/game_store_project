require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative( 'controllers/developers_controller')
require_relative( 'controllers/publishers_controller')
require_relative( 'controllers/games_controller')
require_relative( 'controllers/tags_controller')
require_relative( 'controllers/taggings_controller')
require_relative( 'controllers/tools_controller')

get '/' do
  erb( :index )
end
