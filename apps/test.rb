require 'json'
require 'date'
require 'open-uri'

class Test < Dumbstore::App
  name 'Drones'
  author 'Ramsey Nasser'
  author_url 'http://nas.sr/'
  description <<-DESCRIPTION
  Reads out statistics on the latest American drone strike. Based on the <a href="http://dronestre.am">DroneStream</a> API by <a href="http://joshbegley.com/">Josh Begley</a>.
  DESCRIPTION

  voice_id 'drone'
end