require 'nokogiri'
require 'open-uri'
require 'date'

class Tvshows < Dumbstore::App
  name 'TVShows'
  author 'Hassan Shamim'
  author_url 'https://github.com/hassanshamim'
  description 'Displays a list of TV shows which have new episodes airing today.'

  text_id 'shows'
  def text params
    doc = Nokogiri::HTML(open("http://www.sidereel.com/calendar?utm_medium=sms&utm_source=dumbstore"))
    titles = doc.css(".current .show-title").map{|n| n.inner_text }

    response = "New episodes for #{Date.today.strftime}:  " + titles.join(",  ")
    response.to_sms
  end
end
