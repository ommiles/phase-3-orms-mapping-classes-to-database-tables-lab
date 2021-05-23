class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
  attr_accessor :name, :grade
  attr_reader :id

  # Student instances initialize with a name, grade and optional id
  # when new Students are instantiated, they will not receive an id, so default value of the id param is set to nil
  def initialize(name, grade, id=nil) 
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    # use a heredoc to store SQL statement in a variable
    sql =  <<-SQL 
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
        )
    SQL
    
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    # execute SQL statement against the database using DB[:conn].execute(sql)
    DB[:conn].execute(sql)
  end
  
  def save
    # saves instance variables into db
    # use bound params as name and grade values
    sql = <<-SQL
    INSERT INTO students (name, grade)
    VALUES (?, ?)
    SQL
    
    DB[:conn].execute(sql, self.name, self.grade)
    # grab the ID of the last inserted row (just created)...
    # ... and assign it to the be the value of the @id attribute of the given instance.
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:)
    # instantiate new Student obj and store in student var
    student = Student.new(name, grade)
    #  call the save instance method with Student obj
    student.save
    # return the Student ojb that has been created
    student
  end
end
