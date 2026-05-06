class User < ApplicationRecord
  has_secure_password
  has_many :reports
  enum role: { general: 0, admin: 1 }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, if: :password_required?

  private

  def password_required?
    new_record? || password.present?
  end
end
