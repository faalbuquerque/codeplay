class AddTeacherRefToCourse < ActiveRecord::Migration[6.1]
  def change
    add_reference :courses, :teacher, foreign_key: true
  end
end
