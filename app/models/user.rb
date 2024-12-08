class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  has_secure_password
  has_many :tasks

  private

  def passwords_must_match
    if password != password_confirmation
      errors.add(:password_confirmation, "не совпадает с паролем")
    end
  end
end
