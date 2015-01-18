require 'nokogiri'
require 'open-uri'

class Airpollution < Dumbstore::App
    name 'Air Pollution'
    author 'David Su'
    author_url 'http://usdivad.com/'
    description <<-DESCRIPTION
    Receive the AQI (air quality index) in a given city or zipcode area via SMS.
    Data drawn from <a href="http://aqicn.org/">AQICN</a> and <a href="http://airnow.org/">AirNow</a>.
    Usage: <code>airpollution [city or zipcode]</code>
    DESCRIPTION
    text_id 'airpollution'

    # Scrape AQI values from one of the source websites, depending on whether input is city or zip
    def get_aqi input
        values = []
        begin
            if input.match(/^\d+$/)
                # Zip input
                zipcode = input.to_i
                base = 'http://airnow.gov/index.cfm?action=airnow.local_city&zipcode='
                page = Nokogiri::HTML(open(base + zipcode.to_s))
                values = page.to_s.scan(/(?<=lg\.gif">)\s*\d+/)
                values = values.map{|v| v.strip()}
            else
                # City input
                city = input.gsub(/\s+/, '').downcase
                base = 'http://aqicn.org/city/'
                page = Nokogiri::HTML(open(base + city))
                values = page.css('.aqivalue')
                values = values.map{|v| v.text}
            end
        rescue OpenURI::HTTPError
            p "HTTP error! Likely 404 not found"
        end

        if values.empty?
            return "Sorry, no air pollution data available for #{input.capitalize}."
        else
            return values[0]
        end
    end

    # Format AQI value, e.g. "96: Moderate"
    def format_aqi aqi
        if aqi.match(/^\d+$/)
            aqi_desc = case aqi.to_i
                when 0..50 then "Good"
                when 51..100 then "Moderate"
                when 101..150 then "Unhealthy for Sensitive Groups"
                when 151..200 then "Unhealthy"
                when 201..300 then "Very Unhealthy"
                else "Hazardous"
            end
            return "AQI: #{aqi} (#{aqi_desc})"
        else
            return aqi
        end
    end

    # SMS support
    def text params
        msg_body = params['Body']
        "<Response><Sms>#{format_aqi(get_aqi(msg_body))}</Sms></Response>"
    end
end