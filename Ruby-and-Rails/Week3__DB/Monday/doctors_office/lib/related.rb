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
      @related_tables = tables_names.map(&:to_s)
    end

    def name_crosstable(other)
      [
        name.downcase.en.plural,
        other.class.name.downcase.en.plural
      ].sort.join('_')
    end

    def we_know_it?(method_name)
      @related_tables.any? method_name.to_s # we store strings
    end

    def classname_sort(*items)
      items.sort { |this, that| this.class.to_s <=> that.class.to_s }
    end
  end

  def column_names(other)
    [
      "#{self.class.name.downcase}_id",
      "#{other.class.name.downcase}_id"
    ].sort.join(', ')
  end

  def respond_to_missing?(method_name, *args, &block)
    self.class.we_know_it?(method_name) || super
  end

  def method_missing(method_name, *args, &block)
    super unless self.class.we_know_it? method_name

    #### We have only one such method, no need to come out :) ####
    # Get all doctor's patients

    # method name is a name for the correspondent class, but in plural, symbolic, and lowercase
    related_class = Object.const_get(method_name.to_s.en.plural.capitalize)
    columns = related_class.columns

    related_table = method_name.to_s
    related_id = "#{related_table.en.plural}_id"
    columns_list = "#{related_table}.id, #{columns.join(', ')}"
    cross_table = [
      self.class.name.downcase.en.plural,
      related_table
    ].sort.join('_')

    self_id_name = "#{self.class.name.downcase}_id"

    DB.exec(" SELECT #{columns_list} FROM #{related_table} "\
            " JOIN #{cross_table} ON (#{related_table}.id = #{related_id}) " \
            " WHERE #{self_id_name} = #{id}; ")
      .map { |record| related_class.new(record) }
  end

  def add_related(related)
    table = self.class.name_crosstable(related)
    ids_ranged = self.class.classname_sort(self, related).map(&:id).join(', ')

    DB.exec(" INSERT INTO #{table} "\
            " (#{column_names(related)}) "\
            " VALUES (#{ids_ranged});")
  end
end
