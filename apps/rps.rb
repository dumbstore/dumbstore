class Rps < Dumbstore::App
  name 'Rock Paper Scissors'
  author 'Uiri'
  author_url 'http://xqz.ca/'
  description <<-DESCRIPTION
  Play rock, paper or scissors against a computer.
  DESCRIPTION

  text_id 'rps'
  
  def text params
    choices = ["rock", "paper", "scissors"]
    compchoice = rand(3)
    playerchoice = choices.find_index(params['Body'])
    win = true
    res = nil
    if playerchoice != nil
      if playerchoice < compchoice
        win = false
        if playerchoice == 0 && compchoice == 2
          win = true
        end
      end
      if compchoice == playerchoice
        res = "Computer also chose #{choices[compchoice]}. You tie."
      elsif win
        res = "Computer chose #{choices[compchoice]}. You win!"
      else
        res = "Computer chose #{choices[compchoice]}. You lose :("
      end
    else
      res = "That isn't rock, paper OR scissors!"
    end
    "<Response><Sms>#{res}</Sms></Response>"
  end
end
