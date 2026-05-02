class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :name, null: false
      t.date :admission_date
      t.integer :enrollment_status, default: 0
      t.text :memo

      t.timestamps
    end
  end
end
