require 'sinatra'

# dumblib
module Dumbstore
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
end

# dumbapp
class Weather < App
  # voice_id 'weather'
  text_id 'weather'

  def voice
    
  end

  def text params
    "<Response><Sms>The weather in #{params['Body']} is probably shitty!</Sms></Response>"
  end
end

# startup
Dumbstore::Text.register_app Weather.text_id, Weather

get '/' do
  erb :index
end

# post '/voice' do
#   if params['Digits']
#     Dumbstore::Voice.get(params['Digits']).voice
#   else
#     erb :voice_welcome
#   end
# end

post '/text' do
  param_ary = params['Body'].split
  app_id = param_ary.shift
  params['Body'] = param_ary.join ' '

  Dumbstore::Text.get(app_id).text(params)
end