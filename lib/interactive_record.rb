require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord

  def initialize(options = {})
    options.each do |propery, value|
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
