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
      @related_tables.any? method_name
    end
  end

  def column_names(other)
    [
      "id_#{self.class.name.downcase}",
      "id_#{other.class.name.downcase}"
    ].sort.join(', ')
  end


  
  def respond_to_missing?(method_name, *args, &block)
    self.class.we_know_it?(method_name.to_s) || super
  end

  def method_missing(method_name, *args, &block)
    super unless self.class.we_know_it? method_name

    #### We have only one such method, no need to went out :D ####
    
    raise NotImplemented
  end

  def add_related(related)
    table = self.class.name_crosstable(related.class.name.downcase.en.plural)

    
    DB.exec(" INSERT INTO #{table} ")
    #### TODO ####
    raise NotImplemented
  end
end
