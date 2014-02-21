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
    ascii_art.push(" .       .\n
 |\\-----/|\n
 | o   o | \n
&gt;|==&gt;v&lt;==|&lt;\n
 \\   ^   /\n
  ==(M)==  \n
 /       \\\n
")
    # Rando pug
    ascii_art.push("  __________  \n
 / /  /\\  \\ \\  \n
/ / ^ || ^ \\ \\  \n
\\/|(O))((O)|\\/  \n
  | /(..)\ |      \n
 /\\/ /--\\ \\/\\ \n
/  --------  \\   \n
")
    # Latte art from barista at Glass Shop 
    ascii_art.push("   _-----_   \n
 - .._ _.. -       \n
/ (((\\v/))) \\    \n
|   \\\\|//   |### \n
\\    \\Y/    /__/-\n
 -    |    -       \n
  \"\"-----\"\"    \n
")
    # Phoenix sunset
    ascii_art.push(".................\n
.................\n
  _| ** * **__   \n
 |:|_ **_**/--\\ \n
-|::.|*(_)*|--|_-\n
  ______  ______ \n
 /__[]_L\\/__[]_L\\ \n
-----------------\n
")
    # Duckface selfie
    ascii_art.push("\n
_   _  __  \n
o \\ o |* |\n
  <   |_m| \n
      / /  \n
")

    ##ascii_art.shuffle!
    ##ascii_art.first.to_sms
    "<Response><Sms>#{ascii_art.first}</Sms></Response>"
    ##"<Response><Sms>Asciigram\n---------\nApp is experiencing technical difficulties.</Sms></Response>"
  end
end