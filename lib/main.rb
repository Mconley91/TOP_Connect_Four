# frozen_string_literal: true

class Game 
  attr_reader :game_board
  
  def initialize
    @round = 1
    @player_turn = 'Player 1'
    @game_board
  end

  def make_board
    @game_board = Array.new(6, Array.new(7, '_'))
  end

  def make_play
    loop do
      play = gets.chomp
      return play if play =~ /[1-7]/
      p 'invalid input, try again!'
    end
  end

  #methods for visual readout to console

  def display_board
    @game_board.each{|element| p element}
  end

  def display_round
    puts "ROUND: #{@round}"
  end

  def display_player_turn
    puts "It is now #{@player_turn}'s turn"
  end

  def display_game
    display_round
    display_player_turn
    display_board
  end
end

# test play area
# test_game = Game.new
# test_game.make_board
# test_game.display_game
# test_game.make_play