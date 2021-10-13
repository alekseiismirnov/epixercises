# frozen_string_literal: true

require 'date'
# kind of a wrapper around the string
class Message
  attr_reader :text, :id, :timestamp, :board_id

  def initialize(params)
    @timestamp = params[:timestamp] || DateTime.now
    @text = params[:text]
    @id ||= params[:id]
    @board_id = params[:board_id].to_i
  end

  def self.clear
    DB.exec('DELETE FROM messages *;')
  end

  def self.find(id)
    record = DB.exec("SELECT * FROM messages WHERE id = #{id};").first
    Message.new(to_my_params(record))
  end

  def self.search(params)
    pattern = DB.escape params[:text]
    within = params[:within]

    sql_command = "SELECT id FROM messages WHERE text LIKE '%#{pattern}%'"
    sql_command += within.empty? ? ';' : " AND WHERE id IN ('#{within.map(&:to_i)}');"

    DB.exec(sql_command).map do |record|
      record['id'].to_i
    end
  end

  def self.all
    DB.exec('SELECT * FROM messages;').map do |record|
      Message.new(to_my_params(record))
    end
  end

  def self.to_my_params(record)
    {
      id: record['id'].to_i,
      text: record['text'],
      board_id: record['board_id'],
      timestamp: DateTime.parse(record['timestamp'])
    }
  end

  def save
    text = DB.escape @text
    if id.nil?
      sql_command = "INSERT INTO messages (text, timestamp, board_id) \
                     VALUES('#{text}', '#{@timestamp}', #{@board_id}) \
                     RETURNING id ;"

      @id = DB.exec(sql_command).first['id'].to_i
    else
      sql_command = "UPDATE messages SET text = '#{text}' WHERE id = #{id};"
      #              "UPDATE contacts SET name = 'Wes Anderson' WHERE id = 1;"
      DB.exec sql_command
    end
  end

  def update(params)
    @text = params[:text] if params[:text]
    save
  end

  def delete
    DB.exec("DELETE FROM messages WHERE id = #{id};")
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
