# frozen_string_literal: true

require './lib/output.rb'

class Game 
  attr_accessor :game_board , :player_turn
  
  def initialize
    @round = 1
    @player_turn = 'X'
    @game_board= []
  end

  include Output_To_Terminal

  # row array is reversed so that indexes match with display
  def make_board
    @game_board = Array.new(6){Array.new(7){"_"}.reverse}
  end

  def make_play
    loop do
      play = gets.chomp
      return play if play =~ /[1-7]/
      p 'invalid input!'
    end
  end

  def place_play(column)
    @game_board.each do|row| 
      if row[column - 1] == '_'
        row[column - 1] = @player_turn
        return
      end
    end
  end

  def full_column?(column)
    @game_board[5][column - 1] != '_'
  end

  def cycle_player(player)
    @player_turn = player == 'X' ? 'O' : 'X'
  end

end

# test play area-------------
test_game = Game.new
test_game.make_board
test_game.make_play # to get user input later
test_game.display_game