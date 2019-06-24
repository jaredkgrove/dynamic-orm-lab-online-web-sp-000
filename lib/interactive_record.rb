require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'pry'
class InteractiveRecord

  def table_name_for_insert
    self.class.table_name
  end

  def col_names_for_insert
    binding.pry
    self.class.column_names
  end

  def initialize(options = {})
    options.each do |property, value|
      self.send("#{property}=", value)
    end
  end

  def self.table_name
    self.to_s.downcase.pluralize
  end

  def self.column_names
    DB[:conn].results_as_hash= true
    sql =<<-SQL
      PRAGMA table_info(#{self.table_name})
    SQL
    DB[:conn].execute(sql).collect{|col| col["name"]}.compact
  end
end
