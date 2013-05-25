class Info < Dumbstore::App
  name 'Info'
  author 'Ryan Yeske'
  author_url 'http://ryanyeske.com/'
  description <<-DESCRIPTION
  Get info for dumbstore apps. Text 'info' for a list of all available apps. Text 'info' followed by the the name of the app to get that app's description.
  DESCRIPTION

  def info_for id
    app = Dumbstore::Text.apps[id]
    app ? app.description.strip : "No info for #{id}"
  end

  def app_ids
    Dumbstore::Text.apps.map { |k,v| k }
  end

  def info params
    id = params['Body']
    
    if id.empty?
      "Available Apps: #{app_ids.join(', ')}" 
    else
      info_for id
    end
  end

  text_id 'info'
  def text params
    info(params).to_sms
  end
end