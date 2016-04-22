class ArtistsController < ApplicationController
  get '/?' do
    @artists = Artist.all
    erb :"artists/index.html"
  end

  get '/:id' do
    @artist = Artist.find(params[:id])
    erb :"artists/show.html"
  end
end
