# encoding: UTF-8
#require 'easy_translate'

class UniversalTranslator < Dumbstore::App
  name 'Universal Translator'
  author 'David Huerta'
  author_url 'http://www.davidhuerta.me'
  description <<-DESCRIPTION 
  Translate a word into a different language. A given word is auto-detected and, by default, 
  translated to English. Uses ISO 693-1 codes for specifying language.<br />
  Format: <code>ut [translation code] [word]</code><br />
  Examples: <code>ut Flughafen</code><br />
  <code>ut es Flughafen</code>
  DESCRIPTION
  text_id 'ut'

  def text params
    # This key works only in dumbsto.re, you'll want your own API key to use in your own dumbstore implementation
    # Google Translate API key can be acquired here: https://cloud.google.com/translate/v2/getting_started
    EasyTranslate.api_key = "AIzaSyBS9qbDSodyYKxOJx6I8mXLQ0iFYWnWAEU"
    message_chunks = params['Body'].downcase.split(" ")
    #lang_codes = gt.supported_languages() # two-dimensional array of ISO 639-1 codes
    lang_codes = EasyTranslate::LANGUAGES
    translated_text = "¯\\(°_o)/¯"

    # Check if the first word is a lang code
    if (message_chunks.length > 1)
      if (lang_codes.include?(message_chunks[0]))
        translated_text = EasyTranslate.translate message_chunks[1..message_chunks.length] * " ", :format => 'text', :to => message_chunks[0]
      else
        translated_text = EasyTranslate.translate message_chunks[1..message_chunks.length] * " ", :format => 'text', :to => :en
      end
    else
      #Automatically detect language, translate to English
      logger.info "Werd: #{message_chunks[0]}"
      translated_text = EasyTranslate.translate message_chunks[0], :format => 'text', :to => :en
    end

    translated_text.to_sms
  end
end
