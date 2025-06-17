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

  # array is reversed so that indexes match when array is displayed bottom-to-top
  def make_board
    @game_board = Array.new(6){Array.new(7){"_"}.reverse}
  end

  def make_play
    loop do
      play = gets.chomp
      return play.to_i - 1 if play =~ /[1-7]/ && !self.full_column?(play.to_i - 1)
      p 'invalid input!'
    end
  end

  def place_play(column)
    @game_board.each do|row| 
      if row[column] == '_'
        row[column] = @player_turn
        return
      end
    end
  end

  def full_column?(column)
    @game_board[5][column] != '_'
  end

  def cycle_player(player)
    @player_turn = player == 'X' ? 'O' : 'X'
  end

  def handle_play
    make_board
    loop do
      display_game
      place_play(make_play)
      display_game
      cycle_player(@player_turn)
    end
  end
end

# test play area-------------
# test_game = Game.new
# test_game.handle_play