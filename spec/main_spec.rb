# frozen_string_literal: true

require './lib/main.rb'

describe Game do
  subject(:new_game){described_class.new}
  describe '#make_board' do
  context 'makes a blank game board' do
    before do
      new_game.make_board
    end
    it 'create an array' do
      expect(new_game.game_board).to be_a(Array)
    end
    it 'has 6 elements' do
      expect(new_game.game_board.length).to be 6
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
    
  end
end