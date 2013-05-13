# encoding: utf-8

require 'forecast_io'
require 'geocoder'

class Weather < Dumbstore::App
  text_id 'weather'

  def text params

	message_body = params['Body']

	lat = Geocoder.search("#{message_body}").first.geometry["location"]["lat"]
	lng = Geocoder.search("#{message_body}").first.geometry["location"]["lng"]

	Forecast::IO.api_key = '49f769efb11fc808363e17f9d04c428f'

	forecast = Forecast::IO.forecast(lat, lng)
	forecast_current = "It is currently #{forecast.currently.temperature} degrees and #{forecast.hourly.summary}"
	forecast_future = forecast.daily.summary.gsub(/°/," degrees")

    "<Response><Sms>#{forecast_current}#{forecast_future}</Sms></Response>"
  end
end

