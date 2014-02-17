require 'twilio-ruby'

# extensions
class String
  def to_touchtones
    gsub(/[abc]/i, '2').
    gsub(/[def]/i, '3').
    gsub(/[ghi]/i, '4').
    gsub(/[jkl]/i, '5').
    gsub(/[mno]/i, '6').
    gsub(/[pqrs]/i, '7').
    gsub(/[tuv]/i, '8').
    gsub(/[wxyz]/i, '9')
  end

  def to_class_name
    capitalize.gsub(/[-_.\s]([a-zA-Z0-9])/) { $1.upcase }.gsub('+', 'x')
  end

  def to_fragments pages=false, size=160
    fragments = [""]

    size -= 4 if pages

    split.each do |word|
      if fragments.last.length + word.length + 1 > size
        fragments.push word 
      else
        fragments.last << " #{word}"
      end
    end

    fragments.map! { |fragment| fragment.strip }

    if pages and fragments.size > 1
      n = 0
      fragments.map! do |fragment|
        n += 1
        "#{n}/#{fragments.length} #{fragment}"
      end
    end

    fragments
  end

  def to_sms
    Twilio::TwiML::Response.new do |r|
      to_fragments(true).each do |fragment|
        r.Sms fragment.strip
      end
    end.text
  end

  def to_voice voice='woman'
    Twilio::TwiML::Response.new do |r|
      r.Say self, :voice => voice
    end.text
  end
end

module Dumbstore
  class AppNotFoundError < RuntimeError; end
  module AppContainer
    def apps
      @apps
    end

    def get id
      raise AppNotFoundError unless @apps[id]
      @apps[id].new
    end

    def register_app id, app_class
      @apps ||= {}
      @apps[id] = app_class
    end
  end

  module Voice; extend AppContainer end
  module Text; extend AppContainer end

  class <<self
    attr_accessor :account_sid, :auth_token
  end

  @phone_number = nil

  def self.phone_number
    if @phone_number.nil?
      Dumbstore.twilio.incoming_phone_numbers.list.each do |number|
        smsid = Dumbstore.twilio.incoming_phone_numbers.get(number.sid).sms_application_sid
        voiceid = Dumbstore.twilio.incoming_phone_numbers.get(number.sid).voice_application_sid

        if Dumbstore.twilio.applications.get(smsid).friendly_name == Dumbstore.twilio_app_name and
          Dumbstore.twilio.applications.get(voiceid).friendly_name == Dumbstore.twilio_app_name
          @phone_number = Dumbstore.twilio.incoming_phone_numbers.get(number.sid).phone_number
          break
        end
      end
    end

    @phone_number
  end

  def self.twilio
    @twilio_client ||= Twilio::REST::Client.new ENV['DUMBSTORE_ACCOUNT_SID'], ENV['DUMBSTORE_AUTH_TOKEN'] #self.account_sid, self.auth_token
    @twilio_client.account
  end

  class App
    def self.app_property *props
      props.each do |prop|
        module_eval <<-EVAL
        @#{prop} = nil
        def self.#{prop} *args
          if args.empty?
            @#{prop}
          else
            @#{prop} = args.first
          end
        end
        EVAL
      end
    end
    
    app_property :text_id, :voice_id
    app_property :name, :author, :author_url, :url, :description

    def self.register!
      Dumbstore::Text.register_app self.text_id, self if self.text_id
      Dumbstore::Voice.register_app self.voice_id.to_touchtones, self if self.voice_id
    end

    def self.register_all!
      Dir['apps/*'].map do |filename|
        require_relative '../' + filename
        const_get(File.basename(filename, '.*').to_class_name).register!
      end
    end
  end
end
