require 'sinatra'
require_relative 'lib/dumb'

Dumbstore::App.register_all!

# routes
get('/') { erb :index }
get('/apps') { @apps = Dumbstore::Text.apps.merge(Dumbstore::Voice.apps).values.uniq; erb :apps }
get('/about') { erb :about }
get('/documentation') { erb :documentation }

post '/voice' do
  @params = params
  if params['Digits']
    begin
      Dumbstore::Voice.get(params['Digits']).voice(params)
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
    @app_id = param_ary.shift
    params['Body'] = param_ary.join ' '

    begin
      Dumbstore::Text.get(@app_id).text(params)
    rescue
      # TODO differentiate errors
      erb :text_error
    end
  end
end