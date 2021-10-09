# frozen_string_literal: true

require_relative './spec_helper.rb'

describe Message do
  before :all do
    Message.clear
    @text = 'Test message text'
    @message = Message.new(text: @text)
  end

  context 'with default constructor' do
    it 'contains a text' do
      expect(@message.text).to eq @text
    end
  end
end
