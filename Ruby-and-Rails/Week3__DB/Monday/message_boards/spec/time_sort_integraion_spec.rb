# frozen_string_literal: true
require_relative './spec_helper.rb'

require 'boards_and_messages'

Capybara.app = Sinatra::Application
set(show_exception: false)

Capybara.save_path = '~/tmp'

class Board
  def self.fake_timestamps!
    all.each.with_index do |board, index|
      DB.exec("UPDATE boards SET timestamp = '#{board.timestamp + index}' WHERE id = #{board.id};")
    end
  end
end

describe('Sort', type: :feature) do
  before :all do
    Message.clear
    Board.clear

    @bbs = BBS.new(boards_number: 5, messages_number: 10)
    Board.fake_timestamps!
  end

  context 'boards list' do
    before :each do
      visit '/boards'
    end

    # this test relies on a hash order
    it 'can be sorted from oldest to newest' do
      click_button 'Newest first'
      titles = all('li').map(&:text)

      expect(titles).to eq @bbs.boards.map(&:title).reverse
    end

    # this is even worse test, good only for check if there is a button
    # and press on it doesn't ruin everything
    it 'can be sorted from newest to oldest' do
      click_button 'Oldest first'
      titles = all('li').map(&:text)
      expect(titles).to eq @bbs.boards.map(&:title)
    end
  end
end
