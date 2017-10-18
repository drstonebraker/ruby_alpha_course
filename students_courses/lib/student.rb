class Student
  attr_reader :first_name, :last_name, :courses

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = []
  end

  def name
    "#{@first_name} #{@last_name}"
  end

  def enroll(course)
    raise "there is a conflicting course" if @courses.any?{|old| old.conflicts_with?(course)}
    @courses << course unless @courses.include?(course)
    course.students << self
  end

  def course_load
    result = Hash.new(0)
    @courses.each do |course|
      result[course.department] += course.credits
    end
    result
  end
end
