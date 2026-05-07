class AddTagIdToStudents < ActiveRecord::Migration[7.0]
  def change
    add_reference :students, :tag, null: true, foreign_key: true
  end
end
