class EightBall < Dumbstore::App
	name 'Magic 8 Ball'
	author 'Chris Gervang'
	author_url 'http://gervangster.wordpress.com/'
	description <<-DESCRIPTION
	Ask the 8 ball a yes-no question, and an answer you shall receive. A good one to try is "Magic 8 Ball, will I win the lottery today?"
	DESCRIPTION

	text_id '8ball'

	def text params
		#source: wikipedia article on 8 ball
		fortune = ["It is certain", "It is decidedly so", "Without a doubt", "Yes, definitely", 
			"You may rely on it", "As I see it, yes", "Most likely", "Outlook good", "Yes", 
			"Signs point to yes", "Reply hazy, try again", "Ask again later", "Better not tell you now",
			"Cannot predict now", "Concentrate and ask again", "Don't count on it", "My reply is no", 
			"My sources say no", "Outlook not so good", "Very doubtful"]
		#mix em' up!
		fortune.shuffle!
		
		"<Response><Sms>#{fortune.first}</Sms></Response>"
	end
end