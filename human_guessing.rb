require_relative 'display.rb'

class CodeBreaker
  include Display
  
  def initialize()
    system("clear")
    @turn = 1
    @code = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
    self.play_turn
  end
  
  def play_turn
    print "Guess \##{@turn}: "
    guess = get_input
    outcome(get_feedback(@code, guess))
  end

  def get_input
    input = gets.chomp.split("").map{|i| i.to_i} 
    return input if input.all?{|i| (1..6) === i} && input.length == 4
    puts "\e[41mInvalid guess, please type a 4 digit number in range 1-6. e.g. \"1261\"\e[0m \n\n"
    get_input
  end

  def get_feedback(org_code, guess)
  print "Hints "
  code = org_code.dup
  feedback = []
  guess.zip(code).each_with_index do |set, index|
    if set[0] == set[1]
      code.delete_at(index - (4 - code.length))
      guess.delete_at(index - (4 - guess.length))
      self.green(feedback)
    end
  end
  
  (code & guess).reduce(0) {|sum, i| sum += code.count(i)}.times {self.orange(feedback)}
  puts "\n\n"
  return feedback
  end

  def outcome(feedback)
    if feedback.all?("G") && feedback.length == 4
      puts "\e[42mCongratulations!\e[0m Play again? [y/n]" 
      gets.chomp.downcase == "y" ? Game.new : p {puts "Thanks for playing!"}
    elsif @turn < 12
      @turn += 1
      play_turn
    else
      print "\e[41mYou loose\e[0m, the code was #{@code.join("")}. Play again? [y/n] "
      if gets.chomp.downcase == "y"  
        Game.new 
      else
         puts "Thanks for playing!"
      end
    end
  end
end



