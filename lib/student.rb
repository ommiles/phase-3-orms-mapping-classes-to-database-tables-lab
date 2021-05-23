class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
    INSERT INTO students (name, grade)
    VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.drop_table
    sql = <<-SQL
    DELETE student ()
    SQL
    DB[:conn].execute(sql)
  end

  def self.create
    
  end

  def save
  end

end
