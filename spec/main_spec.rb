# frozen_string_literal: true

require './lib/main.rb'

describe Game do
  describe '#make_board' do
    subject(:new_game){described_class.new}
    context 'makes a blank game board' do
      before do
        new_game.make_board
      end
      it 'create an array' do
        expect(new_game.game_board).to be_a(Array)
      end
      it 'has 6 elements' do
        expect(new_game.game_board.length).to eq(6)
      end
      it 'each element is a sub-array' do
        expect(new_game.game_board.each{|array| array}).to be_a(Array)
      end
      it 'all sub-arrays have 7 elements' do
        expect(new_game.game_board.all?{|array| array.length == 7}).to be true
      end
    end
  end

  describe '#make_play' do
    subject(:play_game){described_class.new}
    context 'takes player input and returns it if valid'do
      before do
        allow(play_game).to receive(:gets).and_return('0','2')
        allow(play_game).to receive(:p) #prevents p statements from printing to console
      end
      it 'prints a message to the console if input is invalid' do
        play_game.make_board
        expect(play_game).to receive(:p).with('invalid input!').once
        play_game.make_play
      end
      it 'takes a column number and returns a valid index position' do
        play_game.make_board
        expect(play_game.make_play).to eq(1)
      end
    end
  end

  describe '#place_play' do
    subject(:place_game){described_class.new}
    context 'places a token in a given column' do  
      before do
        allow(place_game).to receive(:make_play).and_return(0)
      end
      it 'places the token in the corresponding column' do
        place_game.make_board
        place_game.place_play(place_game.make_play)
        # place_game.display_board
        expect(place_game.game_board[0][0]).to eq('X'||'O')
      end
    end
  end

  describe '#full_column?' do
  subject(:test_column_game){described_class.new}
    context 'returns a bool' do
      it 'returns true when the selected column is full' do
        column_two = 2
        test_column_game.make_board
        test_column_game.place_play(column_two)
        test_column_game.place_play(column_two)
        test_column_game.place_play(column_two)
        test_column_game.place_play(column_two)
        test_column_game.place_play(column_two)
        test_column_game.place_play(column_two)
        # test_column_game.display_board
        expect(test_column_game.full_column?(column_two)).to be true
      end

      it 'returns false when the selected column is not full' do
        column_four = 4
        test_column_game.make_board
        test_column_game.place_play(column_four)
        test_column_game.place_play(column_four)
        test_column_game.place_play(column_four)
        test_column_game.place_play(column_four)
        test_column_game.place_play(column_four)
        # test_column_game.display_board
        expect(test_column_game.full_column?(column_four)).to be false
      end
    end
  end

  describe '#cycle_player' do
    subject(:test_player_game){described_class.new}
    context 'changes the current player' do
      it "changes the current player to 'O' if player_turn is 'X'" do
        player = 'X'
        test_player_game.cycle_player(player)
        expect(test_player_game.player_turn).to be 'O'
      end

      it "changes the current player to 'X' if player_turn is 'O'" do
        player = 'O'
        test_player_game.cycle_player(player)
        expect(test_player_game.player_turn).to be 'X'
      end
    end
  end

  describe '#increment_round' do
  subject(:test_increment_game){described_class.new}
    context 'increments the round' do
      it 'by one' do
        test_increment_game.increment_round
        expect(test_increment_game.round).to be(2)
      end
    end
  end

  describe '#winning_plays' do
  subject(:test_win_game){described_class.new}
    context 'returns a bool if there is a winner' do
      it 'returns true when a player has won with a horizontal play' do
        test_win_game.make_board
        test_win_game.place_play(3)
        test_win_game.place_play(4)
        test_win_game.place_play(5)
        test_win_game.place_play(6)
        # test_win_game.display_game
        expect(test_win_game.winning_plays).to be(true)
      end

      it 'returns true when a player has won with a verticle play' do
        test_win_game.make_board
        test_win_game.place_play(3)
        test_win_game.place_play(3)
        test_win_game.place_play(3)
        test_win_game.place_play(3)
        # test_win_game.display_game
        expect(test_win_game.winning_plays).to be(true)
      end

      it 'returns false if no player has won' do
        test_win_game.make_board
        test_win_game.place_play(0)
        test_win_game.place_play(4)
        test_win_game.place_play(5)
        test_win_game.place_play(6)
        # test_win_game.display_game
        expect(test_win_game.winning_plays).to be(false)
      end
    end
  end



end