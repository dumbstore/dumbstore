require 'date'

class Sunsign < Dumbstore::App
  name 'Sunsign'
  author 'Kevin Driscoll'
  author_url 'http://kevindriscoll.org/'
  description "Retrieve the zodiac Sun sign for a given birth month and day (e.g., august 11)"

  text_id 'sunsign'

def get_birthdate(s)
  Date.parse(s.downcase.strip)
end

def get_sign(birthdate)
  birthday = birthdate.strftime('%j').to_i
  if birthday < 21
    "Capricorn"
  elsif birthday < 51
    "Aquarius"
  elsif birthday < 80
    "Pisces"
  elsif birthday < 111
    "Aries"
  elsif birthday < 142
    "Taurus"
  elsif birthday < 173
    "Gemini"
  elsif birthday < 204
    "Cancer" 
  elsif birthday < 235
    "Leo"
  elsif birthday < 267
    "Virgo"
  elsif birthday < 296
    "Libra"
  elsif birthday < 327
    "Scorpio"
  elsif birthday < 356
    "Sagittarius"
  elsif birthday < 366
    "Capricorn"
  else
    "¯\_(ツ)_/¯"
  end
end

  def text(params)
    text = params["Body"]
    bdate = get_birthdate(text)
    sign = get_sign(bdate)
    month_day = bdate.strftime('%b %e')
    "<Response>
      <Sms>The Sun sign for someone born on #{month_day} is #{sign}.</Sms>
    </Response>"
  end

  private :get_birthdate, :get_sign

end