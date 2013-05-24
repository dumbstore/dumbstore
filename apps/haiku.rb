require 'open-uri'
require 'json'

class Haiku < Dumbstore::App
  name 'Haiku'
  author 'Cory Forsyth'
  author_url 'http://coryforsyth.com/'
  description "Get a random haiku, powered by isitahaiku.com"

  HAIKU_URL = "http://isitahaiku.com/haikus/random.json"

  text_id 'haiku'
  voice_id 'haiku'

  def text(params)
    "<Response><Sms>#{haiku}</Sms></Response>"
  end

  def voice params
    "<Response><Say voice='woman'>#{haiku}</Say></Response>"
  end

  private

  def haiku
    begin
      JSON.parse( open(HAIKU_URL).read )['text']
    rescue => e
      "Error finding haiku, please try again."
    end
  end
end
