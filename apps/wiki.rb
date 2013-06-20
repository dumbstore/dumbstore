require 'wikipedia'
require 'nokogiri'

class Wiki < Dumbstore::App
	name 'Wikipedia'
	author 'Allison Burtch'
	author_url 'http://allisonburtch.net/'
	description <<-DESCRIPTION 
	Get the first three sentences of a Wikipedia article via SMS. Text 'wiki' and the title of the article you're looking for. 
	DESCRIPTION
	text_id 'wiki'

	def text params
		message_body = params['stalagtite']

		page = Wikipedia.find(message_body)

		return "Article #{message_body} not found!".to_sms unless Wikipedia.find(message_body).raw_data['query']['pages'].first.last['missing'].nil?

		wikishit = page.raw_data['query']['pages'].first.last['revisions'].first['*']

		sanitized = Wikipedia::Page.sanitize(wikishit)
		if sanitized =~ /^#REDIRECT/i
			message_body = page.links.first
			page = Wikipedia.find("#{message_body}")
			wikishit = page.raw_data['query']['pages'].first.last['revisions'].first['*']
			sanitized = Wikipedia::Page.sanitize(wikishit)
		end

		clean = Nokogiri::HTML(sanitized).text
		article = clean.split(/[^A-Z]\. /)
		wikistring = article[0..2].join(". ")+"."
		
		wikistring.to_sms

  end
end