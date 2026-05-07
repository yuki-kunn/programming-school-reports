class Tag < ApplicationRecord
  has_many :students, dependent: :nullify

  validates :name, presence: true, uniqueness: true
end
