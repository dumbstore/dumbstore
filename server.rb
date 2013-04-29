require "sinatra"
require "mongo"
require "json"
require 'digest/sha1'

SALT = "1d24c22947c20fd016404302d92116a7"

DB = ENV['MONGOLAB_URI'] || "mongodb://heroku_app15360888:fl7s97tgbunbt7rtogpu0p2cij@ds061787.mongolab.com:61787/heroku_app15360888"
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
  $db["users"].insert email: params[:email], phonenumber: Digest::SHA1.hexdigest(params[:phonenumber] + SALT), password: params[:password]

  redirect '/', 301
end

get '/user/:number' do
  # read from database
  user = $db["users"].find("phonenumber" => params[:number]).to_a.first

  if user
    { username: user['email'], password: user['password'] }.to_json
  else
    { error: "user not found" }.to_json
  end
end