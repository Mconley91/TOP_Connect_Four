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
    @game_board.each_with_index do|row,row_index| 
      if row[column] == '_'
        row[column] = @player_turn
        set_last_play(row_index, column)
        return
      end
    end
  end

  def set_last_play(row_index, column_index)
    @coords = [row_index, column_index]
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

  def is_winner?
    row = @coords[0]
    column = @coords[1]
    return true if horizontal_win?(row,column)
    return true if vertical_win?(row,column)
    return true if diagonal_win?(row,column)
    false
  end

  def horizontal_win?(row,column)
    right = 0
    left = 0
    4.times do |i|
      @game_board[row][column + i] == @player_turn ? right += 1 : break
    end
    4.times do |i|
      @game_board[row][column - i] == @player_turn ? left += 1 : break
    end
    right_left = right + left - 1
    return true if left == 4 || right == 4 || right_left == 4
  end

  def vertical_win?(row,column)
    down = 0
    4.times do |i|
      @game_board[row - i][column] == @player_turn ? down += 1 : break
    end
    return true if down == 4
  end

  def diagonal_win?(row,column)
    top_right = 0
    bottom_right = 0
    bottom_left = 0
    top_left = 0
    4.times do |i|
      @game_board[row + i <= 5 ? row + i : break][column + i] == @player_turn ? top_right += 1 : break
    end
    4.times do |i|
      @game_board[row - i][column + i] == @player_turn ? bottom_right += 1 : break
    end
    4.times do |i|
      @game_board[row - i][column - i] == @player_turn ? bottom_left += 1 : break
    end
    4.times do |i|
      if @game_board[row + i >= 5 ? row + i : break] != nil
        @game_board[row + i >= 5 ? row + i : break][column - i > 0 ? column - i : break] == @player_turn ? top_left += 1 : break
      end
    end
    top_right_bottom_left = top_right + bottom_left - 1
    bottom_right_top_left = bottom_right + top_left - 1
    return true if top_right == 4 || bottom_right == 4 ||
                   bottom_left == 4 || top_left == 4 ||
                   top_right_bottom_left == 4 || bottom_right_top_left == 4
  end

  def is_tie?
    return true if @game_board.all?{|array| array.all?{|element| element != '_'}} && !is_winner?
  end

  def handle_play
    make_board
    display_game
    loop do
      place_play(make_play)
      if is_winner?
        display_victory
        return
      elsif is_tie?
        display_tie
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
