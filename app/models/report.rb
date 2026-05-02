class Report < ApplicationRecord
  belongs_to :user
  belongs_to :student

  validates :learning_date, presence: true
  validates :content, presence: true
end
