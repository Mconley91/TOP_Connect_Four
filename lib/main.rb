# frozen_string_literal: true

class Game 
  attr_reader :game_board
  
  def initialize
    @round = 1
    @turn = 'Player 1'
    @game_board
  end

  def make_board
    @game_board = Array.new(6, Array.new(7, '_'))
  end

  def print_board
    @game_board.each{|element| p element}
  end

end

# test play area
test_game = Game.new
test_game.make_board
test_game.print_board