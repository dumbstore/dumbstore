class TextRoulette < Dumbstore::App
  author 'quantumpotato'
  author_url 'https://github.com/quantumpotato'
  description 'leave a message, take a message'

  text_id 'tr'

  def text params
    new_message = params['Body']
    #post new message to server and return response
    new_message.sub!(' ', '%20')
    u = URI.parse("http://dumbtextroulette.herokuapp.com/#{new_message}")
    msg = Net::HTTP.get_response(u).body
    "<Response><Sms>#{msg}</Sms><Response>"
  end

end

