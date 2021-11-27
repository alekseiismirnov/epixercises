# frozen_string_literal: true

require 'linguistics'
Linguistics.use :en # for the table naming

# class name have to correspond to the 
module Related
  class << self
    def included(base)
      base.extend ClassMethods
    end
  end

  module ClassMethods
    def assign_related(*tables_names)
      @related_tables = tables_names
      @relation_tables = tables_names.map { |n| name_relation_table(n) }
    end

    def name_relation_table(table_name)
      [
        name.to_s.downcase.en.plural,
        table_name.to_s
      ].sort.join('_').to_sym
    end
  end
end
