require "sinatra"

get '/' do
  erb :index
end

get '/signup' do
  erb :signup
end

post '/newuser' do
  # write to database
  redirect '/index', 301
end

get '/user/:number' do
  # read from database
end