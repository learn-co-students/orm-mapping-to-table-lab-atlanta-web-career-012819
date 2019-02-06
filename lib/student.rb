class Student

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end
  attr_accessor :grade
  attr_reader :name, :id

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students
    (id INTEGER PRIMARY KEY, name TEXT, grade TEXT);
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
    DROP TABLE IF EXISTS
    students;
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
    INSERT INTO students
    (name, grade) VALUES
    (?, ?);
    SQL
    DB[:conn].execute(sql,name,grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid()
").flatten.first
  end

  def self.create(student_hash)
    student = Student.new(student_hash[:name],student_hash[:grade])
    student.save
    student
  end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

end
