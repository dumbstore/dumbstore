# encoding: utf-8

class Flashlight < Dumbstore::App
	name 'Flashlight'
	author 'Lauren McCarthy'
	author_url 'http://lauren-mccarthy.com/'
	description <<-DESCRIPTION
	Turns your dumbphone into a flashlight. Note: this only works if your phone lights up on sms receive.
	DESCRIPTION

  text_id 'flashlight'
  
  def text params
    10.times do
      Dumbstore.twilio.sms.messages.create(
        from:Dumbstore::NUMBER,
        to:params['From']
        body:" flash "
      )
      sleep 5
    end
    
    nil
  end

end
