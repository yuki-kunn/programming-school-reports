class Student < ApplicationRecord
  has_many :reports

  validates :name, presence: true
  enum enrollment_status: { active: 0, graduated: 1, on_leave: 2 }
end
