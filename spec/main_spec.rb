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
        allow(play_game).to receive(:gets).and_return('0','1')
        allow(play_game).to receive(:p) #prevents p statements from printing to console
      end
      it 'prints a message to the console if input is invalid' do
        expect(play_game).to receive(:p).with('invalid input!').once
        play_game.make_play
      end
      it 'returns a valid input' do
        expect(play_game.make_play).to eq('1')
      end
    end
  end

  describe '#place_play' do
    subject(:place_game){described_class.new}
    context 'places a token in a given column' do  
      it 'places a token in the bottom row of the left column' do
        column_left = 1
        place_game.make_board
        place_game.place_play(column_left)
        # place_game.display_board
        expect(place_game.game_board[0][0]).to eq('X'||'O')
      end

      it 'places a token in the bottom row of the right column' do
        column_right= 7
        place_game.make_board
        place_game.place_play(column_right)
        # place_game.display_board
        expect(place_game.game_board[0][6]).to eq('X'||'O')
      end

      it 'places a token in the bottom row of the middle column' do
        column_middle= 4
        place_game.make_board
        place_game.place_play(column_middle)
        # place_game.display_board
        expect(place_game.game_board[0][3]).to eq('X'||'O')
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

end