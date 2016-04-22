require_relative 'config/environment'
require 'erb'

class ApplicationController
  private
  def render_page_for(resource, page)
      template = File.read("app/views/#{resource}/#{page}.html.erb")
      response = ERB.new(template).result(binding)
      Rack::Response.new(response)
  end

end

class ArtistsController < ApplicationController
  def index
    @artists = Artist.all
    render_page_for("artists", "index")
  end

  def show(id)
    @artist = Artist.find(id)
    render_page_for("artists", "show")
  end
end

class AlbumsController < ApplicationController
  def index
    @albums = Album.all
    render_page_for("albums", "index")
  end

  def show(id)
    @album = Album.find(id)
    render_page_for("albums", "show")
  end
end

class App
  def call(env)
    request = Rack::Request.new(env)
    if request.get? && request.path == "/"
      render_page_for("home", "index")

    elsif request.get? && request.path == "/artists"
      controller = ArtistsController.new
      controller.index

    elsif request.get? && request.path == "/albums"
      controller = AlbumsController.new
      controller.index

    elsif request.get? && request.path =~ /\/artists\/.+/
      id = request.path.split("/").last

      controller = ArtistsController.new
      controller.show(id)

    elsif request.get? && request.path =~ /\/albums\/.+/
      id = request.path.split("/").last

      controller = AlbumsController.new
      controller.show(id)
    else
      Rack::Response.new("File not found", 404)
    end
  end
end

use Rack::ContentType
run App.new
