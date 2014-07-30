require 'nokogiri'
require 'open-uri'

class Doge < Dumbstore::App
  name 'Dogecoin Prices'
  author 'David Huerta'
  author_url 'http://www.davidhuerta.me'
  description <<-DESCRIPTION
  such exchange price<br />
               many currency<br />
    wow<br />
  Format: <code>doge [currency code]</code><br />
  Example: <code>doge USD</code>
  DESCRIPTION
  text_id 'doge'

  def text params
    currency_code = params['Body'].upcase
    page = Nokogiri::HTML(open('http://www.cryptocoincharts.info/v2/coins/show/doge'))
    #price_title_cell = page.xpath("//td[text()='DOGE Prices']").first
    #prices = price_title_cell.next_sibling.text # should contain prices but blank for some reason
    price_cell = page.xpath("//td[contains(., 'USD')]")[1] # pick second instance mentioning currency
    matches = price_cell.text.scan(/\t(.*)#{currency_code}/)

    price = matches.empty? ? nil : matches.first[0].to_s.strip

    if price.nil?
      "Currency not found.".to_sms
    else
      "#{price}#{currency_code}".to_sms
    end
  end
end