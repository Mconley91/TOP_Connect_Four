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
      it 'places a token in the lowest row possible for that column' do
        # column = 5
        # place_game.place_play(column)
        # expect(place_game.game_board[6][4]).to eq('X')
      end
    end
  end

end