# frozen_string_literal: true

require './lib/main.rb'

describe Game do
  subject(:new_game){described_class.new}
  describe '#make_board' do
    it 'create an array' do
      new_game.make_board
      expect(new_game.game_board).to be_a(Array)
    end
    it 'has 6 elements' do
      new_game.make_board
      expect(new_game.game_board.length).to be 6
    end
    it 'each element is a sub-array' do
      new_game.make_board
      expect(new_game.game_board.each{|array| array}).to be_a(Array)
    end
    it 'all sub-arrays have 7 elements' do
      new_game.make_board
      expect(new_game.game_board.all?{|array| array.length == 7}).to be true
    end
  end
end