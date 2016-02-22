class InteractiveRecord
  
  def self.table_name
    self.to_s.downcase + "s"
  end

  def self.column_names
    DB[:conn].results_as_hash = true

    sql = "PRAGMA table_info('#{table_name}')"
    table_info = DB[:conn].execute(sql)

    table_info.map { |column| column["name"]}.compact
  end

  def initialize(attributes = {})
    #cheeto = Student.new(name: "cheeto", grade: 6)
    attributes.each do |property, value|
      #interpolation converts symbol to string
      self.send("#{property}=", value)
    end
  end

  def save
    if self.id
      self.update
    else
      sql = "INSERT INTO #{table_name_for_insert} (#{col_names_for_insert}) VALUES (#{values_for_insert});"
      DB[:conn].execute(sql)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM #{table_name_for_insert}")[0][0]
      self
    end
  end

  def self.find_by_name(name)
    sql = "SELECT * from #{table_name} WHERE name = ?;"
    row = DB[:conn].execute(sql, name).flatten
    #
    #
  end

  def self.find_by(attributes = {})
    where_selection = attributes.keys.map {|key| "#{key} = ?"}.join(" AND ")
    values = attributes.values
    sql = "SELECT * FROM #{table_name} WHERE #{where_selection};"
    DB[:conn].execute(sql, *values)
  end

  def col_names_for_insert
    self.class.column_names.reject {|name| name == "id"}.join(', ')
  end

  def values_for_insert
    self.class.column_names.each_with_object([]) do |col_name, values|
      values << "'#{send(col_name)}'" unless send(col_name).nil?
    end.join(", ")
  end

  def values
    self.class.column_names.each_with_object([]) do |col_name, values|
      values << "'#{send(col_name)}'" unless send(col_name).nil?
    end
  end

  def table_name_for_insert
    self.class.table_name
  end

  def update
    set_info = self.class.column_names.map do |name|
      "#{name} = ?"
    end.join(', ')

    values_array = self.values

    sql = <<-SQL
      UPDATE #{table_name_for_insert}
      SET #{set_info}
      WHERE id = ?
    SQL
    DB[:conn].execute(sql, *values_array)
    self
  end

end