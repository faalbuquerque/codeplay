class ChangeTeacherNullOnCourse < ActiveRecord::Migration[6.1]
  def change
    change_column_null :courses, :teacher_id, false
  end
end
