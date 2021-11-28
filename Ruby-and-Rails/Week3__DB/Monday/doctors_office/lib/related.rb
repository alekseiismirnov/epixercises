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

    def name_relation_table(table_name)
      [
        name.downcase.en.plural,
        table_name
      ].sort.join('_')
    end

    def we_know_it?(method_name)
      related_tables.any? method_name
    end
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
    table = [
      name.downcase.plural,
      related.class.name.to_s.plural
    ].sort.join('_')
    #### TODO ####
    raise NotImplemented
  end
end
