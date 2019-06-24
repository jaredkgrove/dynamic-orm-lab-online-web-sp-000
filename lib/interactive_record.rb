require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord
  def self.table_name
    self.to_s.downcase.pluralize
  end

  def self.column_names
    DB[:conn].results_as_hash= true
    sql =<<-SQL
      PRAGMA table_info(#{self.table_name})
    SQL
    DB[:conn].execute(sql).collect do |col|
      col["name"]
    end.compact
  end
end
