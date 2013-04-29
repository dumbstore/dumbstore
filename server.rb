require "sinatra"

DB = ENV['MONGOLAB_URI']
uri = URI.parse(DB)
conn = Mongo::Connection.from_uri(DB)
$db = conn.db(uri.path.gsub(/^\//, ''))

get '/' do
  erb :index
end

get '/signup' do
  erb :signup
end

post '/newuser' do
  # write to database
  $db["users"].insert params

  redirect '/index', 301
end

get '/user/:number' do
  # $db["users"].insert params[:number]
  # read from database
end