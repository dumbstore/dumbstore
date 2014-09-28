require 'HTTParty'

class Thesaurus < Dumbstore::App
  name 'Thesuarus'
  author 'Liz Goldstein'
  author_url 'http://cira.io/'
  description <<-DESCRIPTION
  Text a word, and get a list of synonyms back!
  For example, text <code>thesaurus awesome</code> and get a list of synonyms back.
  DESCRIPTION

  text_id 'thesaurus'

  def text params
    word = params['Body']

    newWord = HTTParty.get("http://words.bighugelabs.com/api/2/7caa3a1500e79fc0d78fe9a508dd6942/#{word}/")

    if newWord = nil
      response = "No synonym found."
    else
      response = "Try #{newWord}"
    end

    response.to_sms

  end
end
