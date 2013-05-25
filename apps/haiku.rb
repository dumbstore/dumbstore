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
    haiku.to_sms
  end

  def voice params
    haiku.to_voice
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
