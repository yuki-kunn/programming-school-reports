class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.date :learning_date, null: false, default: -> { 'CURRENT_DATE' }
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
