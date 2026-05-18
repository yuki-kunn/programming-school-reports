class User < ApplicationRecord
  has_secure_password
  has_many :reports, dependent: :destroy

  enum role: { general: 0, admin: 1 }

  before_save { self.email = email.downcase }

  validates :name,     presence: true
  validates :email,    presence: true,
                       uniqueness: { case_sensitive: false },
                       format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, if: :password_required?

  # ランダムトークンを生成して digest を保存し、生トークンを返す
  def remember
    token = SecureRandom.urlsafe_base64
    update_column(:remember_digest, BCrypt::Password.create(token))
    token
  end

  # remember_digest をクリアする
  def forget
    update_column(:remember_digest, nil)
  end

  # cookie のトークンが digest と一致するか検証
  def authenticated_by_token?(token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(token)
  end

  private

  def password_required?
    new_record? || password.present?
  end
end
