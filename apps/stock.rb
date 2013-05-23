class Stock < Dumbstore::App
	name 'Stocks Prices'
	author 'Antoine de Chevigne'
	author_url 'http://github.com/antoinedc'
	description <<-DESCRIPTION
	Get the current stock price of a company (based on Yahoo! Finance API).<br />
	Format: <code>stock [symbol]</code><br />
	Example: <code>stock YHOO</code>
	DESCRIPTION
	text_id 'stock'
	voice_id 'stock'

	def stock params
		symb = params['Body']
		url = "http://download.finance.yahoo.com/d/quotes.json?f=l1&s=" + symb
		price = Net::HTTP.get_response(URI.parse(url)).body.strip
		if price == "0.00"
			"Symbol not found."
		else
			price
		end

	end

	def text params
		"<Response><Sms>#{stock(params)}</Sms></Response>"
	end

	def voice params
		"<Response><Say voice='woman'>#{stock(params)}</Say></Response>"
	end
end