require 'json'
require 'date'
require 'open-uri'

class Drone < Dumbstore::App
  name 'Drones'
  author 'Ramsey Nasser'
  author_url 'http://nas.sr/'
  description <<-DESCRIPTION
  Reads out statistics on the latest American drone strike. Based on the <a href="http://dronestre.am">DroneStream</a> API by <a href="http://joshbegley.com/">Josh Begley</a>.
  DESCRIPTION

  voice_id 'drone'

  def voice params
    data = JSON.parse(open("http://api.dronestre.am/data").read)['strike'].last

    message = "The most recent drone strike was on #{DateTime.parse(data['date']).strftime('%A %B %e %Y')} "
    message += "in #{data['town']}, #{data['location']}, #{data['country']}. "
    message += "The target was #{data['target']}" unless data['target'].empty?

    message += "There were #{data['deaths'].gsub('-', ' to ')} deaths. " if data['deaths'] != "1" and not data['deaths'].empty?
    message += "There was one death. " if data['deaths'] == "1"
    
    message += "There were #{data['injuries'].gsub('-', ' to ')} injuries. " if data['injuries'] != "1" and not data['injuries'].empty?
    message += "There was one injury. " if data['injuries'] == "1"

    unless data['civilians'].empty? and data['children'].empty?
      message += "Among them, "
      message += "#{data['civilians']} were civilians" if data['civilians'] != 1 and not data['civilians'].empty?
      message += "one was a civilian" if data['civilians'] == '1'

      message += "#{data['children']} were children" if data['children'] != 1 and not data['children'].empty?
      message += "one was a child" if data['children'] == '1'
      message += ". "
    end

    unless data['names'].length == 1 and data['names'].first.empty?
      message += "Their names were #{data['names'].join(', ')}"
      message += '.'
    else
      message += "Their names are not known. "
    end

    message += "Rest in peace. " unless data['deaths'].empty? or data['deaths'] == '0'

    "<Response><Say voice='woman'>#{message}</Say></Response>"
  end
end