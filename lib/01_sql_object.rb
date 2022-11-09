require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    return @columns if @columns
    #array of objects from the sql query. .exec and .exex2
    #first entry is array of column names
    results = DBConnection.execute2("SELECT * FROM #{table_name}")
    @columns = results.first.map(&:to_sym)

  end

  def self.finalize!
    # columns = self.columns 
    self.columns.each do |column|
      define_method("#{column}=".to_sym) do |new_value|
        # instance_variable_set("#{column}", new_value)
        attributes[column] = new_value
      end

      define_method("#{column}".to_sym) do 
        # instance_variable_get("#{column}")
        attributes[column]
      end

    end

  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    @table_name = self.to_s.downcase + 's'
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
    params.each do |key, val|
      key_sym = key.to_sym
      raise "unknown attribute '#{key}'" if !self.class.columns.include?(key_sym)
      send("#{key_sym}=", val)
    end
  end

  def attributes
    # ...
    @attributes ||={}
  end

  def attribute_values
    # ...
    @attributes ||={}
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
