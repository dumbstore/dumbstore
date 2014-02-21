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
    #ascii_art.push("derp\n    herp\nderp\n");
    ascii_art.push(" |\\------/|
| o    o | 
|=&gt;v&lt;=|
 \\   ^   /
  =(M)=
 /        \\
")
    # Rando pug
    ascii_art.push("  __________
 / /  /\\  \\ \\
/ / ^ || ^ \\ \\
\\/|(O))((O)|\\/
  | /(..)\ |
 /\\/ /--\\ \\/\\
/  --------  \\
")
    # Latte art from barista at Glass Shop 
    ascii_art.push("   _-----_
 - .._ _.. -
/ (((\\v/))) \\
|   \\\\|//   |###
\\    \\Y/    /__/
 -    |    -
  \"\"-----\"\"
")
    # Phoenix sunset
    ascii_art.push(".................
.................
  _| ** * **__ 
 |:|_ **_**/--\\
-|::.|*(_)*|--|_-
  ______  ______
 /__[]_L\\/__[]_L\\
-----------------
")
    # Duckface selfie
    ascii_art.push("
_   _  __
o \\ o |* |
  &lt;   |_m|
      / /
")

    ##ascii_art.shuffle!
    ##ascii_art.first.to_sms
    "<Response><Sms>#{ascii_art.first}</Sms></Response>"
    ##"<Response><Sms>Asciigram\n---------\nApp is experiencing technical difficulties.</Sms></Response>"
  end
end