# frozen_string_literal: true

require 'date'
# kind of a wrapper around the string
class Message
  attr_reader :text, :id, :timestamp, :board_id

  @my_objects = {}
  @last_id = 0

  def initialize(params)
    @timestamp = params[:timestamp] || DateTime.now
    @text = params[:text]
    @id = params[:id] || self.class.free_id
    @board_id = params[:board_id]
  end

  def self.save_me(my_object)
    @my_objects[my_object.id] = my_object.clone
  end

  def self.clear
    @my_objects = {}
    @last_id = 0
  end

  def self.free_id
    @last_id += 1
  end

  def self.find(id)
    @my_objects[id].clone
  end

  def self.search(params)
    pattern = params[:text]
    within = params[:within]

    (within.nil? ? @my_objects.values : @my_objects.values_at(*within))
      .select { |message| message.text.include?(pattern) }
      .map(&:id)
  end

  def self.delete(id)
    @my_objects.delete(id)
  end

  def self.all
    @my_objects.values
  end

  def save
    self.class.save_me self
  end

  def clone
    self.class.new(text: text, id: id, board_id: board_id, timestamp: timestamp)
  end

  def update(params)
    @text = params[:text] if params[:text]
    @timestamp = params[:timestamp] if params[:timestamp]
    save
  end

  def to_json(*_args)
    {
      timestamp: @timestamp,
      id: @id,
      text: @text,
      board_id: @board_id
    }
  end
end
