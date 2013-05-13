class Weather < Dumbstore::App
  voice_id 'weather'
  text_id 'weather'

  def voice params
    "<Response><Say voice='woman'>It is probably a beautiful day, but I can't know for sure!</Say></Response>"
  end

  def text params
    "<Response><Sms>The weather in #{params['Body']} is probably shitty!</Sms></Response>"
  end
end