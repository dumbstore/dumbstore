require 'net/http'
require 'rexml/document'

class Sfmuni < Dumbstore::App
	name 'San Francisco MUNI schedules'
	author 'Antoine de Chevigne'
	author_url 'http://github.com/antoinedc'
	description <<-DESCRIPTION
	Get the next San Francsico MUNI schedule.<br />
	Format: <code>sfmuni [line] [stop]</code><br />
	Example: <code>sfmuni 71 4941</code>
	DESCRIPTION
	text_id 'sfmuni'
	voice_id 'sfmuni'

	def schedule params
		message_body = params['Body']
		line = message_body.split(" ")[0]
		stop = message_body.split(" ")[1]
		if stop.length > 4
			stop = stop[1, stop.length-1]
		end
		p stop
		url = "http://webservices.nextbus.com/service/publicXMLFeed?command=predictions&a=sf-muni&r=" + line.to_s + "&s=" + stop.to_s + "&useShortTitles=true"
		xml_data = Net::HTTP.get_response(URI.parse(url)).body

		doc = REXML::Document.new(xml_data)
		minutes = []
		doc.elements.each('body/predictions/direction/prediction') do |el|
		   minutes << el.attributes['minutes']
		end
		res = ""
		if minutes.count == 0
			res ="Nothing scheduled yet..."
		else
			res = "Next MUNI in " + minutes[0].to_s + " minutes."
			if minutes.count > 1
				minutes[1, minutes.count-1].each{ |r| 
					res += "Then, in " + r.to_s + " minutes."
				}
			end
		end
		res
	end

	def text params
		"<Response><Sms>#{schedule(params)}</Sms></Response>"
	end

	def voice params
		"<Response><Say voice='woman'>#{schedule(params)}</Say></Response>"
	end
end