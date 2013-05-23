# encoding: utf-8

require "dicechucker"

class Roll < Dumbstore::App
  name 'Roll'
  author 'Hayk Saakian'
  author_url 'http://twitter.com/hayksaakian'
  description <<-DESCRIPTION
  <code>roll 1d20+4</code>
  Accepts standard dice notation: (XdYS+Z) typically S is either L for 'drop low' or H for 'drop high', or E for 'explode'. 
  Using the <a href='https://github.com/marktabler/dicechucker'>Dicechucker</a> gem by marktabler
  <code>=21 | rolled 17 plus 4 for a total of 21.</code>
  DESCRIPTION

  text_id 'roll'
  def text params
    input =  params['Body'].empty? ? '1d6' : params['Body']
    input.gsub!(' ', '+')
    dice = Dicechucker.parse(input)
    total = dice.roll
    "<Response><Sms>#{total.to_s} || #{input} #{dice.report}</Sms></Response>"
  end
end
