class Quotify < Dumbstore::App
	name 'Quotify'
	author 'Joel Terry'
	author_url 'http://joeldangerterry.tumblr.com/'
	description <<-DESCRIPTION
	Adds quotes to random words and phrases within the input text.
	DESCRIPTION

	text_id 'quotify'

	def quotify params
		message = params['Body'].split
		count = message.length / 3 + rand(message.length / 3) #between 1/3 - 2/3 of the words will be quoted
		quote_indices = []
		while count > 0
			random_index = rand(message.length)
			unless quote_indices.include? random_index
				quote_indices << random_index
				count -= 1
			end
		end
		quote_indices.each{|i| message[i] = '"' + message[i] + '"'}
		i = 0
		phrasing = false
		while i < message.length - 1 #converts adjacent quoted words to quoted phrases ("lets" "eat" "dinner" => "lets eat dinner") 
			if message[i][0].chr == '"' && message[i][-1].chr == '"'
				if phrasing
					if (i == message.length - 1) or (message[i+1][0].chr != '"' && message[i+1][-1].chr != '"')
						message[i] = message[i][1...message[i].length]
						phrasing = false
					else
						message[i] = message[i][1...message[i].length - 1]
					end
				else
					if message[i+1][0].chr == '"' && message[i+1][-1].chr == '"'
						message[i] = message[i][0...message[i].length - 1]
						phrasing = true
					end
				end
			end
			i += 1
		end
		if message[i][0].chr == '"' && message[i][-1].chr == '"' && phrasing
			message[-1] = message[i][1...message[i].length]
		end
		quotify = ''
		message.each{|e| quotify += e + ' '}
		return quotify
	end

	def text params
		quotify(params).to_sms
	end
end