#get '/' do
#  {"respuesta" => "ok"}.to_json
#end
#
#get '/agent' do
#  "you're using #{request.user_agent}"
#end
require "sinatra/sequel"


class TrafficApi < Sinatra::Application
  #enable :sessions

  configure :production do
    set :clean_trace, true
  end

  configure :development do
    # ...
  end

  helpers do
    include Rack::Utils
  end
  puts "Loading configurations"
  Dir["#{$root}/conf/*.rb"].each {|file| require  file }
  puts "Loading Models"
  Dir["#{$root}/app/models/*.rb"].each {|file| require  file }
  puts "Loading controllers"
  Dir["#{$root}/app/controllers/*.rb"].each {|file| require  file }
end


