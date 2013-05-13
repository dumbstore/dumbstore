# encoding: utf-8

require 'forecast_io'
require 'geocoder'

class Weather < Dumbstore::App
  text_id 'weather'

  def text params
  	fragments = [""]
  	MAX_SIZE = 160
	message_body = params['Body']

	lat = Geocoder.search("#{message_body}").first.geometry["location"]["lat"]
	lng = Geocoder.search("#{message_body}").first.geometry["location"]["lng"]

	Forecast::IO.api_key = '49f769efb11fc808363e17f9d04c428f'

	forecast = Forecast::IO.forecast(lat, lng)

	forecast_current = "It is currently #{forecast.currently.temperature} degrees and #{forecast.hourly.summary}"
	forecast_future = forecast.daily.summary.gsub(/°/," degrees")
	forecast_string = forecast_current + forecast_future 

	forecast_string.split.each do |word|
		if fragments.last.length + word.length + 1 > MAX_SIZE
			fragments.push word 
		else
			fragments.last << " #{word}"
		end
	end
	
    "<Response>#{fragments.map { |frags| "<Sms> #{frags} </Sms>" }.join}</Response>"
      
  end
end

