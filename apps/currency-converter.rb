require "nokogiri"
require "open-uri"

class CurrencyConverter < Dumbstore::App
	name 'CurrencyConverter'
	author 'Arnav Roy'
	author_url 'http://www.arnavroy.com/'
	description <<-DESCRIPTION 
	Currency converter. Text 'currency-converter'. In the body of your text, put your source currency code to destination currency code as per http://en.wikipedia.org/wiki/ISO_4217#Active_codes. Ex: <code>currency-converter eur to usd</code>
	DESCRIPTION

	text_id 'currency-converter'

	def text params
		message_body = params['Body']
        split_arr = message_body.split('to')
        return "<Response><Sms>Invalid Request!</Sms></Response>" if split_arr.nil?

		src_currency_code = message_body.split('to')[0]
		dest_currency_code = message_body.split('to')[1]
        src_currency_code.strip!
        dest_currency_code.strip!

        url = 'https://www.google.com/finance/converter?a=1&from=' + src_currency_code + '&to=' + dest_currency_code 
        doc = Nokogiri::HTML(open(url))

        result_nodes = doc.css('#currency_converter_result') 
        return "<Response><Sms>Failed to convert!</Sms></Response>" if (result_nodes.nil? or result_nodes.length < 1)

        result = result_nodes[0].content
        result.strip!
        return "<Response><Sms>" + result + "</Sms></Response>" 
    end
end
        
