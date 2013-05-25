require 'net/http'
require 'rexml/document'

class News < Dumbstore::App
	name 'Google News Headlines'
	author 'Antoine de Chevigne'
	author_url 'http://github.com/antoinedc'
	description <<-DESCRIPTION
	Get the latest headlines from Google News !<br />
	Format: <code>news [country](opt) [query](opt)</code><br />
	Example: <code>news fr lmpt</code>
	If no country is specified, it will be US news, this parameter is a two letter country code<br />
	You can use the query parameter to get the headlines about a particular topic<br />
	Each headline is followed by the source<br />
	DESCRIPTION
	text_id 'news'

	def headlines params
		message_body = params['Body']
		message_words = message_body.split(" ")
		loc = "en"
		q = ""
		if message_words.count > 0
			q = message_words[0]
		end
		if message_words.count > 1
			loc = message_words[0]
			q = message_words[1]
		end
		url = "http://news.google.com/news/feeds?pz=1&cf=all&output=rss&ned=" + loc +"&hl=" + loc + "&q=" + q

		xml_data = Net::HTTP.get_response(URI.parse(url)).body

		doc = REXML::Document.new(xml_data)
		headlines = []
		doc.elements.each('rss/channel/item/title') do |el|
			headlines << el.text
		end

		headlines.join("\n")
	end

	def text params
		headlines(params).to_sms
	end
end