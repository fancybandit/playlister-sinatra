require './config/environment'

begin
  fi_check_migration
  
  use Rack::MethodOverride
  use Rack::Session::Pool
  use Rack::Flash
  use ArtistsController
  use GenresController
  use SongsController
  run ApplicationController
rescue ActiveRecord::PendingMigrationError => err
  STDERR.puts err
  exit 1
end
