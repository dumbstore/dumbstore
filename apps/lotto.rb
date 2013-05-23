class Lotto < Dumbstore::App
  name 'Powerball'
  author 'Jordan Scales'
  author_url 'http://jordanscales.com'
  description 'Generates Powerball Numbers'

  text_id 'lotto'
  def text params
    # Five (5) white balls (1-59) w/out replacement
    # One  (1) red ball    (1-35)
    numbers = (1..59).to_a.sample(5)
    powerball = (1..35).to_a.sample
    "<Response><Sms>Your lucky numbers are: #{numbers.join(' ')} + #{powerball}</Sms></Response>"
  end

  voice_id 'lotto'
  def voice params
    # Five (5) white balls (1-59) w/out replacement
    # One  (1) red ball    (1-35)
    numbers = (1..59).to_a.sample(5)
    powerball = (1..35).to_a.sample
    "<Response><Say>Your lucky numbers are: #{numbers.join(' ')} + #{powerball}</Say></Response>"
  end
end
