class CodeMaker
  def initialize
    system("clear")
    @turn = 1
    print "Type a code that computer will try to break: "
    @code = self.get_code
    @pc_guess = []
    @feedback = []
    @dict = {}
    @possible_answers = []
    for i in 1..6
      for j in 1..6
        for k in 1..6 
          for l in 1..6
            @possible_answers.push([i,j,k,l])
          end
        end
      end
    end
    self.play_turn
  end

  def get_code
    input = gets.chomp.split("").map{|i| i.to_i} 
    puts "\n"
    return input if input.all?{|i| (1..6) === i} && input.length == 4
    puts "\e[41mInvalid code, please type a 4 digit number in range 1-6. e.g. \"1261\"\e[0m \n\n"
    get_code
  end

  def play_turn
    make_a_guess
    puts "Guess \##{@turn}: #{@pc_guess.join("")}"
    outcome(get_feedback(@code))
  end

  def make_a_guess
    if @dict.values.sum != 4
      sample = ([1,2,3,4,5,6] - @dict.keys).sample
      @pc_guess.fill(sample, @dict.values.sum..3)
    elsif @feedback.count("Y") > 0
      yellows = @feedback.count("Y")
      if yellows > 0
        most_likely = []
        @possible_answers.each do |answer|
          sum = 0
          answer.each_with_index do |n, i|
            sum += 1 if n == @pc_guess[i]
          end
          most_likely.push(answer) if 4 - sum == yellows
        end
        @pc_guess = most_likely.sample
      else
        @pc_guess = @possible_answers.sample
      end
    end
  end

  def get_feedback(org_code)
  print "Hints "
  code = org_code.dup
  guess = @pc_guess.dup
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
  @feedback = feedback
  return feedback
  end

  def outcome(feedback)
    if feedback.all?("G") && feedback.length == 4
      puts "Computer Wins! Play again? [y/n]" 
      gets.chomp.downcase == "y" ? Game.new : p {puts "Thanks for playing!"}
    elsif @turn < 12
      if @dict.values.sum != 4
        @dict[@pc_guess[3]] = @feedback.length - @dict.values.sum
      end
      check_possible(feedback)
      @turn += 1
      play_turn
    else
      print "Computer was not able to crack your code, you win! Play again? [y/n] "
      if gets.chomp.downcase == "y"  
        system("clear")
        Game.new
      else
         puts "Thanks for playing!"
      end
    end
  end

  def check_possible(feedback)
    @possible_answers.delete(@pc_guess)

    @possible_answers.select! do |answer|
        valid = []
        @dict.each do |digit|
          valid.push(answer.count(digit[0]) == @dict[digit[0]])
        end
        valid.all?(true)
      end

    if feedback.all?("Y") 
      for i in 0..(feedback.count - 1)
      @possible_answers.select! do |answer|
        answer[i] != @pc_guess[i]
        end
      end
    end
  end
end