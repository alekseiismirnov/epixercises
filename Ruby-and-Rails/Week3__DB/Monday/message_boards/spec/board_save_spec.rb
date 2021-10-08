# frozen_string_literal: true

require_relative './spec_helper.rb'

describe Board do
  before :all do
    Board.clear
    @title = 'Board To save'
    @board = Board.new(title: @title)
    @some_mess = "It's some message"
    @other_mess = "It's an other message"
  end

  context 'board is not saved' do
    it 'list of all boards is empty' do
      Board.clear
      expect(Board.all).to eq []
    end
  end

  context 'one board is saved' do
    before :all do
      @board.save
      @board.save_message(@some_mess)
      @board.save_message(@other_mess)
    end

    it 'list of all boards has length 1' do
      expect(Board.all.length).to eq 1
    end

    it 'is in returned list' do
      expect(Board.all.first).to eq @board
    end

    it 'contains messages' do
      board = Board.find @board.id

      expect(board.messages.map(&:text).sort).to eq [@some_mess, @other_mess].sort
    end
  end
end
