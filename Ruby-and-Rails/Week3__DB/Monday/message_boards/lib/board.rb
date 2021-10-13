# frozen_string_literal: true

require 'date'
require_relative './message.rb'
# titled container for messages
class Board
  attr_reader :title, :id, :timestamp

  def initialize(params)
    @timestamp = params[:timestamp] || DateTime.now
    @title = params[:title]
    @id = params[:id]
  end

  def self.all
    DB.exec('SELECT * FROM boards;').map do |record|
      Board.new(to_my_params(record))
    end
  end

  def self.clear
    DB.exec('DELETE FROM boards *;')
  end

  def self.find(id)
    record = DB.exec("SELECT * FROM boards WHERE id = #{id};").first
    Board.new(to_my_params(record))
  end

  def self.search_messages(search_pattern)
    Board.all.map do |board|
      found_message_ids = board.search_messages(search_pattern)
      next if found_message_ids.empty?

      {
        title: board.title,
        messages: found_message_ids
      }
    end
         .reject(&:nil?)
  end

  def self.search(params)
    # only for titles, obviously
    pattern = params[:title]

    Board.all
         .select { |board| board.title.include?(pattern) }
         .map(&:id)
  end

  def messages
    Message.all.select { |message| message.board_id == @id }
  end

  def save
    if @id.nil?
      report = DB.exec("INSERT INTO boards (title, timestamp) VALUES ('#{title}', '#{timestamp}') RETURNING id;")
      @id = report.first['id'].to_i
    end
    @id
  end

  def self.to_my_params(record)
    {
      id: record['id'].to_i,
      title: record['title'],
      timestamp: DateTime.parse(record['timestamp'])
    }
  end

  def ==(other)
    @title = other.title
  end

  def <=>(other)
    @title <=> other.title
  end

  def save_message(text)
    message = Message.new(text: text, board_id: id)
    message.save
  end

  def to_json(*_args)
    {
      timestamp: timestamp,
      title: title,
      id: id,
      message_ids: message_ids
    }
  end

  def search_messages(pattern)
    DB.exec("SELECT id FROM messages WHERE text LIKE '%#{pattern}%' \
    AND board_id = #{id};").map { |record| record['id'].to_i }
  end

  def delete_message(id)
    Message.delete id
  end

  private

  def message_ids
    Message.all.select { |message| message.board_id == @id }.map(&:id)
  end
end
