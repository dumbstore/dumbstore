# encoding: utf-8

require 'nokogiri'
require 'open-uri'

class Ltrain < Dumbstore::App
  text_id 'ltrain'
  voice_id 'ltrain'

  def fucked
	page = Nokogiri::HTML(open('http://istheltrainfucked.com/'))
		if page.css('h2').text.strip == 'nope'
			return "It's not fucked"
		else 
			return "It's totally fucked"
		end
	end

	def text params
		"<Response><Sms>#{fucked()}</Sms></Response>"
	end

	def voice params
		 "<Response><Say voice='woman'>#{fucked()}</Say></Response>"
	end
end
