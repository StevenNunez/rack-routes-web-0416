class HomeController < ApplicationController
  get '/?' do
    erb :"home/index.html"
  end
end
