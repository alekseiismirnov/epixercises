# frozen_string_literal: true

# column names in table named same as correspondent members
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
      record = DB.exec("SELECT #{columns.join(', ')} "\
                "FROM #{@table} "\
                "WHERE id = #{id};").first

      new(record) unless record.nil?
    end
  end

  def save
    values = self.class.columns.map do |member|
      "'#{public_send(member)}'"
    end
                 .join ', '

    result = DB.exec("INSERT INTO  #{self.class.table} "\
                      " (#{self.class.columns.join(' ,')}) " \
                      " VALUES (#{values}) RETURNING id ;")
    @id = result.first['id'].to_i
  end
end
