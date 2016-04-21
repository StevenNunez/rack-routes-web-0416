require 'pry'
class App
  def call(env)
    request = Rack::Request.new(env)
    if request.get? && request.path == "/"
      Rack::Response.new("<h1>Welcome</h1>")
    else
      Rack::Response.new("File not found", 404)
    end
  end
end

use Rack::ContentType
run App.new
