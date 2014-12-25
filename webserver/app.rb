post '/' do

  puts params.class
  puts params.keys.to_s
  puts params.to_s

  params.to_s
end

get '/agent' do
  "you're using #{request.user_agent}"
end
