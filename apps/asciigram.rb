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
    ascii_art.push(" |\\-----/|
| o    o | 
|=&gt;v&lt;=|
 \\   ^   /
  =(M)=
 /        \\
")
    # Rando pug
    ascii_art.push(" ______________ 
/ / ^ || ^ \\ \\
\\/|(O)(O)|\\/
  | / (..) \\ |
 /\\/ /--\\ \\/\\
/  --------  \\
")
    # Latte art from barista at Glass Shop 
    ascii_art.push(" ...-----...
/ ((\\v/)) \\
|   \\\\|//   |##
\\    \\Y/   /__/
 --__||__--
")
    # Phoenix sunset
    ascii_art.push("
  __| ** * **__ 
|:.|_ **_**/--\\
|:.:.|*(_)*|--|_-
_________________
  __\\___   _\\___
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
    #ascii_art.first.to_sms # this line kills line breaks
    "<Response><Sms>#{ascii_art[2]}</Sms></Response>"
    ##"<Response><Sms>Asciigram\n---------\nApp is experiencing technical difficulties.</Sms></Response>" # nevar forget
  end
end