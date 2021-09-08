module Display
  def green(array)
    print "\e[32m\u25CF\e[0m "
    array.push("G")
  end

  def orange(array)
    print "\e[33m\u25EF\e[0m "
    array.push("Y")
  end
  
  def instructions
    puts "               \e[4mInstructions \e[0m
    
Mastermind is a code cracking game. You can play as either, Code-Maker or Code-Braker

\e[3mCode-Breaker \e[0m
Computer makes a 4 digit code consisting for numbers 1-6 e.g. \"1111\", \"1234\", \"6142\" etc. That you have to guess. You have 12 turns to do so, otherwise computer wins. Each turn you will be provided with hints.

\e[32m\u25CF\e[0m - One of the numbers in your code is correct and in the right place.

\e[33m\u25EF\e[0m - There is a correct number, but it is in the wrong place

If computer makes a code \"1234\" and you guess \"2134\" the hints will show 
\e[32m\u25CF\e[0m \e[32m\u25CF\e[0m \e[33m\u25EF\e[0m \e[33m\u25EF\e[0m

\e[3mCode-Maker \e[0m
You try to make a 4 digit code consisting for numbers 1-6 that computer will be guessing. If your code is hard enough and computer is unable to crack it in 12 turns, you win. 


"
  end
  def choose_game_mode_message
    puts "Who will you play as? Code-Braker or Code-Maker? 
type \"1\" to be a Code-Braker
type \"2\" to be a Code-Maker"
  end
end