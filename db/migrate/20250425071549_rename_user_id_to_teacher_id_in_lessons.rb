class RenameUserIdToTeacherIdInLessons < ActiveRecord::Migration[7.1]
  def change
    rename_column :lessons, :user_id, :teacher_id
  end
end