# encoding: utf-8

require 'nokogiri'
require 'open-uri'

class Ltrain < Dumbstore::App
	name 'Is The L Train Fucked?'
	author 'Allison Burtch'
	author_url 'http://allisonburtch.net/'
	description <<-DESCRIPTION
	Tells you the state of <a href="http://en.wikipedia.org/wiki/L_(New_York_City_Subway_service)">New York\'s L Train</a>.
	Based on <a href="http://istheltrainfucked.com/">istheltrainfucked.com</a> by <a href="http://jonathanvingiano.com/">Jonathan Vingiano</a>.
	DESCRIPTION

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
