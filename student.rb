require './person'

class Student < Person
  def initialize(age,name, parent_permission, classroom: nil)
    super(age, name, parent_permission)
    @classroom = classroom
  end

  def play_hooky
    puts '¯(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end
end
