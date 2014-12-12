require 'nokogiri'
require 'open-uri'

class SecureDrop < Dumbstore::App
	name 'SecureDrop'
	author 'Runa A. Sandvik'
	author_url 'http://encrypted.cc/'
	description <<-DESCRIPTION
	Get three random addresses for <a href="https://freedom.press/securedrop">SecureDrop</a>
	sites, the open-source whistleblower submission system installed at more than a dozen 
	news organizations.
	DESCRIPTION

	text_id 'sd'

	def whistle
		directory = Nokogiri::HTML(open('https://freedom.press/securedrop/directory'))
		onions = directory.xpath('//td[contains(text(), "onion")]').text
		if onions.empty?
			"Something went wrong, please try again later."
		else
			random_onions = onions.split(/(onion)/).each_slice(2).map(&:join).sample(3)
			random_onions.join(" ")
		end
	end
		
	def text params
		"<Response><Sms>#{whistle}</Sms></Response>"
	end
end
