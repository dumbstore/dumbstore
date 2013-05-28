class Rickroulette < Dumbstore::App
  name 'Rick Roulette'
  author 'David Huerta'
  author_url 'http://www.davidhuerta.me'
  description <<-DESCRIPTION
  Call Dumbstore, enter the rick for the ID. Hold your phone up to your head for a 1 in 6 chance of getting rickrolled.
  DESCRIPTION

  voice_id 'rick'
  def voice params
    chambers = Array.new(6)
    # load one in
    chambers[0] = 'rickroll'
    # spin
    chambers.shuffle!

    if chambers.first.nil?
      # click
      "<Response><Say voice='woman'>Click.</Say></Response>"
    else
      # bang!
      "<Response><Play>http://www.davidhuerta.me/lulz/rickroll.mp3</Play></Response>"
    end
  end
end
