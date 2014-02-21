class Asciigram < Dumbstore::App
  name 'Asciigram'
  author 'David Huerta'
  author_url 'http://www.davidhuerta.me'
  description <<-DESCRIPTION
  text <code>asciigram</code> to get a random ascii art cat, pug, latte, sunset or duckface.
  ASCII art by David Huerta, CC0 (public domain).
  DESCRIPTION
  text_id 'asciigram'

  def text params
    ascii_art = Array.new
    # Mu the cat
    ascii_art.push(" .       . \r\n \
 |\-----/| \r\n \
 | o   o | \r\n \
>|==>v<==|<\r\n \
 \   ^   / \r\n \
  ==(M)==  \r\n \
 /       \ \r\n \
")
    # Rando pug
    ascii_art.push("  __________  \r\n \
 / /  /\  \ \ \r\n \
/ / ^ || ^ \ \ \r\n \
\/|(O))((O)|\/\r\n \
  | /(..)\ |  \r\n \
 /\/ /--\ \/\ \r\n \
/  --------  \ \r\n \
")
    # Latte art from barista at Glass Shop 
    ascii_art.push("   _-----_   \r\n \
 - .._ _.. -      \r\n \
/ (((\v/))) \     \r\n \
|   \\\|//   |###\ \r\n \
\    \Y/    /__/- \r\n \
 -    |    -      \r\n \
  \"\"-----\"\"       \r\n \
")
    # Phoenix sunset
    ascii_art.push(".................\r\n \
.................\r\n \
  _| ** * **__   \r\n \
 |:|_ **_**/--\\ \r\n \
-|::.|*(_)*|--|_-\r\n \
  ______  ______ \r\n \
 /__[]_L\\/__[]_L\\ \r\n \
-----------------\r\n \
")
    # Duckface selfie
    ascii_art.push("\r\n \
_   _  __ \r\n \
o \ o |* |\r\n \
  <   |_m|\r\n \
      / / \r\n \
")

    ascii_art.shuffle!
    ascii_art.first.to_sms
  end
end