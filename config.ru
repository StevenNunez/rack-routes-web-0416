require_relative 'config/environment'
require 'erb'

class App
  def call(env)
    request = Rack::Request.new(env)
    if request.get? && request.path == "/"
      home_page = <<-HTML
        <h1>Welcome</h1>
        <ul>
        <li>
          <a href="/artists">See all artists!</a>
        </li>
        <li>
          <a href="/albums">See all albums!</a>
        </li>
        </ul>
      HTML
      Rack::Response.new(home_page)
    elsif request.get? && request.path == "/artists"
      artists = Artist.all
      template = <<-HTML
      <ul>
        <% artists.each do |artist| %>
          <li><a href="/artists/<%= artist.id %>"></a><%= artist.name %></li>
        <% end %>
      </ul>
      HTML
      response = ERB.new(template).result(binding)
      Rack::Response.new(response)

    elsif request.get? && request.path == "/albums"
      albums = Album.all
      template = <<-HTML
      <ul>
        <% albums.each do |album| %>
          <li><a href="/albums/<%= album.id %>"><%= album.title %></a></li>
        <% end %>
      </ul>
      HTML
      response = ERB.new(template).result(binding)
      Rack::Response.new(response)
    elsif request.get? && request.path =~ /\/artists\/.+/
      id = request.path.split("/").last
      artist = Artist.find(id)
      template = <<-HTML
      <h1><%= artist.name %></h1>
      <h3>Albums</h3>
      <ul>
        <% artist.albums.each do |album| %>
         <li><a href="/albums/<%= album.id %>"><%= album.title %></a> </li>
        <% end %>
      </ul>
      HTML
      response = ERB.new(template).result(binding)
      Rack::Response.new(response)
    else
      Rack::Response.new("File not found", 404)
    end
  end
end

use Rack::ContentType
run App.new
