class Report < ApplicationRecord
  belongs_to :user
  belongs_to :student

  validates :learning_date, presence: true,
                            uniqueness: { scope: [:user_id, :student_id],
                                          message: "この生徒の同日の日報はすでに存在します" }
  validates :content, presence: true, length: { maximum: 10_000 }
end
