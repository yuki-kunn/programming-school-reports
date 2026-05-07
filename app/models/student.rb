class Student < ApplicationRecord
  has_many :reports, dependent: :destroy
  belongs_to :tag, optional: true

  validates :name, presence: true
  enum enrollment_status: { active: 0, graduated: 1, on_leave: 2 }
  scope :active_students, -> { where(enrollment_status: :active) }
end
