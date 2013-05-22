class Wall < Dumbstore::App
  name 'Dumbwall'
  author 'Jonathan Dahan'
  author_url 'http://jedahan.com/'
  description <<-DESCRIPTION
  Tag or view a public wall
  DESCRIPTION

  @@tag = 'a nice clean wall, won\'t you tag it?'

  text_id 'wall'
  def text params
    @@tag = params['Body'] unless params['Body'].empty?
    "<Response><Sms>#{@@tag}</Sms></Response>"
  end
end
