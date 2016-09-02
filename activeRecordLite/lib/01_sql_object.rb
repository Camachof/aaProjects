require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    if @column_names
      @column_names
    else
      names = DBConnection.execute2(<<-SQL)
        SELECT
          *
        FROM
          #{self.table_name}
      SQL
      @column_names = names[0].map { |name| name.to_sym }
    end
  end

  def self.finalize!
    columns.each do |column_name|
      define_method("#{column_name}=") do |new_name|
        attributes[column_name] = new_name
      end

      define_method("#{column_name}") do
        attributes[column_name]
      end

    end
  end

  def self.table_name=(table_name)
    @table = table_name
  end

  def self.table_name
    @table ||= self.to_s.tableize
  end

  def self.all
    all_data = DBConnection.execute(<<-SQL)
      SELECT
        #{self.table_name}.*
      FROM
        #{self.table_name}
    SQL
    parse_all(all_data)
  end

  def self.parse_all(results)
    object_list = []
    results.each do |attr_hash|
      object_list << self.new(attr_hash)
    end
    object_list
  end

  def self.find(id)
    find_id = DBConnection.execute(<<-SQL, id)
      SELECT
        #{self.table_name}.*
      FROM
        #{self.table_name}
      WHERE
        #{self.table_name}.id = ?
    SQL
    return nil if find_id.empty?
    self.new(find_id.first)
  end

  def initialize(params = {})
    params.each do |key, val|
      if self.class.columns.include?(key.to_sym)
        self.send "#{key}=".to_sym, val
      else
        raise "unknown attribute '#{key}'"
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    values = []
    self.class.columns.map do |column_name|
      values << self.send(column_name)
    end
    values
  end

  def insert
    col_names = self.class.columns[1..-1].join(", ")
    question_marks = (["?"] * (attribute_values.length - 1)).join(", ")

    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id

  end

  def update
    # ...
  end

  def save
    # ...
  end
end
