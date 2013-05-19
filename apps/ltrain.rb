# encoding: utf-8

require 'nokogiri'
require 'open-uri'

class Ltrain < Dumbstore::App
  text_id 'ltrain'

	def text params

		page = Nokogiri::HTML(open('http://istheltrainfucked.com/'))
		string = nil

		if page.css('h2').text.strip == 'nope'
			string = "It's not fucked"
		else 
			string = "It's totally fucked"
		end

	"<Response><Sms>#{string}</Sms></Response>"
	end
end
