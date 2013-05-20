require 'nokogiri'
require 'google_directions'

class Directions < Dumbstore::App
	name 'Directions'
	author 'Allison Burtch'
	author_url 'http://allisonburtch.net/'
	description <<-DESCRIPTION 
	Google maps directions. Text 'dir'. In the body of your text, put your origin to destination. Ex: <code>dir 721 Broadway to Eyebeam New York, NY</code>
	DESCRIPTION

	text_id 'dir'

	def text params
	  	fragments = [""]
	  	max_size = 160
		message_body = params['Body']

		origin = message_body.split("to")[0]
		destination = message_body.split("to")[1]

		directions = GoogleDirections.new(origin, destination).xml
		distance = GoogleDirections.new(origin, destination).distance_in_miles.to_s

		arr = Nokogiri::HTML(directions).css('html_instructions').to_a

		dir = arr.join(". ")
		final = Nokogiri::HTML(dir).text
		
		final_directions = "It is #{distance} miles away. " + final

		final_directions.split.each do |word|
			if fragments.last.length + word.length + 1 > max_size
				fragments.push word 
			else
				fragments.last << " #{word}"
			end
		end


    "<Response>#{fragments.map { |frags| "<Sms>#{frags.strip}</Sms>" }.join}</Response>"
  end
end




