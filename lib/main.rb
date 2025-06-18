# frozen_string_literal: true

require './lib/output.rb'

class Game 
  attr_accessor :game_board , :player_turn, :round, :coords
  
  def initialize
    @round = 1
    @player_turn = 'X'
    @game_board = []
    @coords = []
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
        set_last_play(row, column)
        return
      end
    end
  end

  def set_last_play(row, column)
    @coords = [@game_board.find_index(row), column]
  end

  def full_column?(column)
    @game_board[5][column] != '_'
  end

  def cycle_player(player)
    @player_turn = player == 'X' ? 'O' : 'X'
  end

  def increment_round
    @round += 1
  end

  def winning_plays
    # using coordinates we can 'look' in any direction from a successfully placed play
    # and determine if a 4 in a row exists
    row = @coords[0]
    column = @coords[1]
    return true if @game_board[row][column..column + 4].all?{|play| play == @player_turn}
    return true if @game_board[row][column - 4..column].all?{|play| play == @player_turn}
    # @game_board.each do |row|
    #   return true if row[0..3].all?{|play| play == @player_turn}
    #   return true if row[1..4].all?{|play| play == @player_turn}
    #   return true if row[2..5].all?{|play| play == @player_turn} 
    #   return true if row[3..6].all?{|play| play == @player_turn}  
    # end
    # verticle wins
    # 7.times do |i|
    #   return true if @game_board[0][i] == @player_turn &&
    #                  @game_board[1][i] == @player_turn &&
    #                  @game_board[2][i] == @player_turn &&
    #                  @game_board[3][i] == @player_turn
    #   return true if @game_board[1][i] == @player_turn &&
    #                  @game_board[2][i] == @player_turn &&
    #                  @game_board[3][i] == @player_turn &&
    #                  @game_board[4][i] == @player_turn
    #   return true if @game_board[2][i] == @player_turn &&
    #                  @game_board[3][i] == @player_turn &&
    #                  @game_board[4][i] == @player_turn &&
    #                  @game_board[5][i] == @player_turn
    # end
    # diagonal wins
    false
  end


  def handle_play
    make_board
    display_game
    loop do
      place_play(make_play)
      if winning_plays
        display_victory
        return
      end
      increment_round
      cycle_player(@player_turn)
      display_game
    end
  end
end

# test play area-------------
test_game = Game.new
test_game.handle_play