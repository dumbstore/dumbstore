require 'sinatra'
require_relative 'lib/dumb'

Dumbstore::App.register_all!

# routes
get('/') { erb :index }
get('/apps') { @apps = Dumbstore::Text.apps.merge(Dumbstore::Voice.apps).values.uniq; erb :apps }
get('/about') { erb :about }
get('/documentation') { erb :documentation }

# These cause method not found errors. See #48
#Dumbstore.twilio_account_sid = ENV['DUMBSTORE_ACCOUNT_SID']
#Dumbstore.twilio_auth_token = ENV['DUMBSTORE_AUTH_TOKEN']
#Dumbstore.twilio_app_name = "Dumbstore - Sandbox"

post '/voice' do
  @params = params
  if params['Digits']
    begin
      Dumbstore::Voice.get(params['Digits']).voice(params) || Twilio::TwiML::Response.new.text
    rescue
      # TODO differentiate errors
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
    @app_id = param_ary.shift.downcase 
    params['Body'] = param_ary.join ' '

    begin
      Dumbstore::Text.get(@app_id).text(params) || Twilio::TwiML::Response.new.text
    rescue Dumbstore::AppNotFoundError => e
      # TODO differentiate errors
      erb :text_app_not_found
    rescue
      erb :text_app_crashed
    end
  end
end
