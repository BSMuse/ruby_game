class Player
  attr_accessor :lives

  def initialize
    @lives = 3
  end

  def lose_life
    @lives -= 1
  end
end

class MathGame
  def initialize
    @player1 = Player.new
    @player2 = Player.new
    @current_player = @player1
  end

  def generate_question
    num1 = rand(1..20)
    num2 = rand(1..20)
    [@current_player, "#{num1} plus #{num2} equals?", num1 + num2]
  end

  def switch_player
    @current_player = (@current_player == @player1) ? @player2 : @player1
  end

  def start
    until game_over?
      player, question, answer = generate_question

      puts "----- NEW TURN -----"
      puts "Player #{player == @player1 ? '1' : '2'}: #{question}"
      print '> '
      player_answer = gets.chomp.to_i

      if player_answer == answer
        puts "Player #{player == @player1 ? '1' : '2'}: YES! You are correct."
      else
        puts "Player #{player == @player1 ? '1' : '2'}: Seriously? No!"
        player.lose_life
      end

      puts "P1: #{@player1.lives}/3 vs P2: #{@player2.lives}/3"
      switch_player
    end

    announce_winner
  end

  def game_over?
    @player1.lives.zero? || @player2.lives.zero?
  end

  def announce_winner
    winner = @player1.lives.zero? ? @player2 : @player1
    loser = @player1.lives.zero? ? @player1 : @player2

    puts "Player #{winner == @player1 ? '2' : '1'} wins with a score of #{winner.lives}/3"
    puts "Player #{loser == @player1 ? '1' : '2'}: #{loser.lives}/3"
    puts "----- GAME OVER -----"
    puts "Good bye!"
  end
end

# Start the game
MathGame.new.start
