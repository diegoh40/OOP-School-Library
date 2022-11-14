require_relative './base_decorator'

class TrimmerDecorator < BaseDecorator
  def correct_name
    new_arr = []
    arr = @nameable.correct_name.chars
    arr.each_with_index do |ele, index|
      new_arr.push(ele) if index < 10
    end
    new_arr.join
  end
end
