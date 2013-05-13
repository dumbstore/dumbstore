require 'sinatra'
require_relative 'lib/dumb'

# dumblib
module Dumbstore
  # TODO clean up copy paste job
  module Voice
    @@apps = {}

    def self.apps
      @@apps
    end

    def self.get id
      raise "AppNotFoundError" unless @@apps[id]
      @@apps[id].new
    end

    def self.register_app id, app_class
      @@apps[id] = app_class
    end
  end

  module Text
    @@apps = {}

    def self.apps
      @@apps
    end

    def self.get id
      # TODO app not found
      @@apps[id].new
    end

    def self.register_app id, app_class
      @@apps[id] = app_class
    end
  end
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
  if params['Digits']
    begin
      Dumbstore::Voice.get(params['Digits']).voice
    rescue
      "<Response><Say voice='woman'>I'm sorry. An app with the ID #{params['Digits']} could not be found. Peace out, boy.</Say></Response>"
    end
  else
    erb :voice_welcome
  end
end

post '/text' do
  if params['Body'].empty?
    erb :text_welcome
  else
    param_ary = params['Body'].split
    app_id = param_ary.shift
    params['Body'] = param_ary.join ' '

    begin
      Dumbstore::Text.get(app_id).text(params)
    rescue
      "<Response><Sms>I'm sorry, an app with the name #{app_id} could not be found. Stay in school.</Sms></Response>"
    end
  end
end