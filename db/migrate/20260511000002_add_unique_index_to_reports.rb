class AddUniqueIndexToReports < ActiveRecord::Migration[7.0]
  def change
    add_index :reports, [:user_id, :student_id, :learning_date],
              unique: true,
              name: 'index_reports_on_user_student_date',
              if_not_exists: true
  end
end
