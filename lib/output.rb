# frozen_string_literal: true

module Output_To_Terminal
  def display_column_numbers
    p %w(1 2 3 4 5 6 7)
  end

  def display_board
    @game_board.reverse.each{|element| p element}
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
    display_column_numbers
    display_board
  end

  def display_victory
    p "#{@player_turn} has won in #{@round} rounds!!!"
    display_column_numbers
    display_board
  end
end