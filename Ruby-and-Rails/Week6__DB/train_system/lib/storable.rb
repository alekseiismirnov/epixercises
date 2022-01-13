# frozen_string_literal: true

# column names in table named same as correspondent members
# FIXME initializer should accept hash argument with string keys
module Storable
  class << self
    def included(base)
      base.extend ClassMethods
    end
  end

  module ClassMethods
    def assign_table(table)
      @table = table
    end

    def table
      @table
    end

    def assign_columns(columns)
      @columns = columns
    end

    def columns
      @columns
    end

    def find(id)
      record = DB.exec("SELECT id, #{columns.join(', ')} "\
                "FROM #{@table} "\
                "WHERE id = #{id};").first

      new(record) unless record.nil?
    end

    # only one column in time search yet
    def search(params)
      search_by = columns.reject { |column| params[column].nil? }
      column = search_by.first # only by one column yet

      DB.exec(" SELECT id, #{columns.join(', ')} "\
              " FROM #{table} "\
              " WHERE #{column} = '#{params[column]}';")
        .map { |record| new(record) }
    end

    def all
      DB.exec(" SELECT id, #{columns.join(', ')} "\
              " FROM #{table} ;")
        .map { |record| new(record) }
    end
  end

  def save
    return @id unless @id.nil?  # we have the `#update` for rewrite

    values = self.class.columns.map do |member|
      "'#{public_send(member)}'"
    end
                 .join ', '

    result = DB.exec(" INSERT INTO  #{self.class.table} "\
                      " (#{self.class.columns.join(', ')}) " \
                      " VALUES (#{values}) RETURNING id ;")
    @id = result.first['id'].to_i
  end

  # just compare all stored fields, except id
  def ==(other)
    self.class.columns.map do |member|
      send(member) == other.send(member)
    end.all?
  end

  def update(params)
    update_by = self.class.columns.reject { |column| params[column].nil? }
    update_by.each do |column|
      member_refer = "@#{column}".to_sym
      instance_variable_set(member_refer, params[column])
    end

    updates = self.class.columns.map do |member|
      "#{member}='#{public_send(member)}'"
    end.join ', '

    DB.exec(" UPDATE #{self.class.table} "\
            " SET #{updates} "\
            " WHERE id=#{@id};")
  end

  def delete
    DB.exec(" DELETE FROM #{self.class.table} "\
            " WHERE id = #{@id}; ")
  end
end
  