require './book'
require './teacher'
require './person'
require './rental'
require './student'

class App
  attr_reader :persons, :books, :rentals

  def initialize
    @persons = []
    @books = []
    @rentals = []
  end

  def menu
    puts ''
    puts 'thanks! for visit my librery'
    puts 'Please choose an option by enterin a number'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
  end

  def choose_options # rubocop:disable Metrics/CyclomaticComplexity
    selected = gets.chomp
    case selected
    when '1' then list_books
    when '2' then list_persons
    when '3' then create_person
    when '4' then create_book
    when '5' then create_rental
    when '6' then list_rentals
    when '7' then abort('Thank you for using School Library App')
    else
      puts 'error, select another number'
      choose_options
    end
  end

  def show_app
    puts 'Welcome to School Library App'
    menu
    choose_options
  end

  def list_books
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
    menu
    choose_options
  end

  def list_persons
    @persons.each do |person|
      puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    menu
    choose_options
  end

  def create_person
    puts 'Do you want to create a student (1) or teacher (2)? [Input the number]: '
    selected = gets.chomp
    case selected
    when '1' then create_student
    when '2' then create_teacher
    else
      puts 'wrong number, select student (1) or teacher (2)'
      create_person
    end
    menu
    choose_options
  end

  def create_student
    puts 'Age: '
    age = gets.chomp
    puts 'Name: '
    name = gets.chomp
    puts 'Has parent permission? [Y/N]: '
    permission = gets.chomp.downcase == 'y'
    student = Student.new(age, name, permission)
    @persons.push(student)
    puts 'Person created successfully'
  end

  def create_teacher
    puts 'Age: '
    age = gets.chomp
    puts 'Name: '
    name = gets.chomp
    puts 'Specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(age, name, specialization)
    @persons.push(teacher)
    puts 'Person created successfully'
  end

  def create_book
    puts 'Title: '
    title = gets.chomp
    puts 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    @books.push(book)
    puts 'Book created successfully'
    menu
    choose_options
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      puts "#{index}) title: #{book.title}, Author: #{book.author}"
    end
    index_book = gets.chomp
    puts ''
    puts 'Select a person from the following list by number'
    @persons.each_with_index do |person, index|
      puts "#{index}) #{person.class} Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    index_person = gets.chomp
    puts ''
    puts 'Date: '
    selected_date = gets.chomp
    rental = Rental.new(selected_date, @books[index_book.to_i], @persons[index_person.to_i])
    @rentals.push(rental)
    puts 'Rental created successfully'
    menu
    choose_options
  end

  def list_rentals
    @persons.each do |person|
      puts "#{person.class} Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    puts 'Select ID of person:'
    person_id = gets.chomp.to_i
    puts 'Rentals: '
    @rentals.each do |rental|
      if rental.person.id == person_id
        puts "Date: #{rental.date}, Book: #{rental.book.title} by: #{rental.book.author}"
      else
        puts 'ID does not match the active member, please try again'

      end
    end
    menu
    choose_options
  end
end
