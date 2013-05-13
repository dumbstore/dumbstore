require 'sinatra'
require_relative 'lib/dumb'

# dumblib
module Dumbstore
  module AppContainer
    @@apps = {}

    def apps
      @@apps
    end

    def get id
      raise "AppNotFoundError" unless @@apps[id]
      @@apps[id].new
    end

    def register_app id, app_class
      @@apps[id] = app_class
    end
  end

  module Voice; extend AppContainer end
  module Text; extend AppContainer end
end

class App
  @@text_id = nil
  def self.text_id *args
    if args.empty?
      @@text_id
    else
      @@text_id = args.first
    end
  end

  @@voice_id = nil
  def self.voice_id *args
    if args.empty?
      @@voice_id
    else
      @@voice_id = args.first.to_touchtones
    end
  end

  def self.register!
    Dumbstore::Text.register_app self.text_id, self if self.text_id
    Dumbstore::Voice.register_app self.voice_id, self if self.voice_id
  end
end

# dumbapp
class Weather < App
  voice_id 'weather'
  text_id 'weather'

  def voice
    "<Response><Say voice='woman'>It is probably a beautiful day, but I can't know for sure!</Say></Response>"
  end

  def text params
    "<Response><Sms>The weather in #{params['Body']} is probably shitty!</Sms></Response>"
  end
end

# startup
Weather.register!

# routes
get '/' do
  erb :index
end

post '/voice' do
  @params = params
  if params['Digits']
    begin
      Dumbstore::Voice.get(params['Digits']).voice(params)
    rescue
      erb :voice_error
    end
  else
    erb :voice_welcome
  end
end

post '/text' do
  @params = params
  if params['Body'].empty?
    erb :text_welcome
  else
    param_ary = params['Body'].split
    @app_id = param_ary.shift
    params['Body'] = param_ary.join ' '

    begin
      Dumbstore::Text.get(@app_id).text(params)
    rescue
      erb :text_error
    end
  end
end