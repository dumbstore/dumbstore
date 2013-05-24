require 'net/http'
require 'rexml/document'

class Tweets < Dumbstore::App
	name 'Dumb Tweets'
	author 'Antoine de Chevigne'
	author_url 'http://github.com/antoinedc'
	description <<-DESCRIPTION
	Get the latest tweets from a user.<br />
	Format: <code>tweets [username]</code><br />
	Example: <code>tweets twitter</code>
	DESCRIPTION
	text_id 'tweets'
	voice_id 'tweets'

	def tweets params
		username = params['Body']
		url = "http://api.twitter.com/1/statuses/user_timeline.xml?screen_name=" + username
		xml_data = Net::HTTP.get_response(URI.parse(url)).body
		doc = REXML::Document.new(xml_data)
		tweets = []
		doc.elements.each('statuses/status') do |el|
		   tweets << el.elements['text'].text
		end
		tweets.join("\r\n")
	end

	def text params
		"<Response><Sms>#{tweets(params)}</Sms></Response>"
	end

	def voice params
		"<Response><Say voice='woman'>#{tweets(params)}</Say></Response>"
	end
end