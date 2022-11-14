require './nameable'
require './capitalize'
require './trimmer'
require './rental'
require './book'

class Person < Nameable
  attr_accessor :name, :age, :rentals

  def initialize(age, name, parent_permission)
    super()
    @id = Random.rand(1..1000)
    @age = age
    @name = name
    @parent_permission = parent_permission
    @rentals = []
  end

  attr_reader :id

  def of_age?
    @age > 18
  end

  def can_use_service
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def add_rentals(rental)
    @rentals.push(rental)
    rental.person = self
  end
end
