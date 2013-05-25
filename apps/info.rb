class Info < Dumbstore::App
  name 'info'
  author 'Ryan Yeske'
  author_url 'http://ryanyeske.com/'
  description <<-DESCRIPTION
  Get info for a dumbstore app. Text 'info' followed by the the name of the app.
  DESCRIPTION

  def info_for id
    app = Dumbstore::Text.apps[id]
    app ? app.description.strip : "no info for #{id}"
  end

  def app_ids
    Dumbstore::Text.apps.map { |k,v| k }
  end

  def info params
    id = params['Body']
    
    if id.empty?
      "#{Info.description.strip}\nApps: #{app_ids.join(' ')}" 
    else
      info_for id
    end
  end

  text_id 'info'
  def text params
    "<Response><Sms>#{info(params)}</Sms></Response>"
  end
end
