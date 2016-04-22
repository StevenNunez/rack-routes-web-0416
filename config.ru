require_relative 'config/environment'
# use AlbumsController
# run ArtistsController

map "/albums" do
  run AlbumsController
end

map "/artists" do
  run ArtistsController
end

run HomeController
