class AlbumsController < ApplicationController
  get '/?' do
    @albums = Album.all
    erb :"albums/index.html"
  end

  # get '/albums/:id' do
  get '/:id' do
    @album = Album.find(params[:id])
    erb :"albums/show.html"
  end
end
