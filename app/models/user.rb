class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :articles, dependent: :destroy
  validates :username, 
  presence: true, 
  length: { 
    minimum: 3, 
    maximum: 25, 
    wrong_length: "Le pseudo de l'utilisateur doit faire entre 3 et 25 caractères"
  }, 
  uniqueness: { case_sensitive: false }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, 
  presence: true, 
  length: { 
    maximum: 100, 
    wrong_length: "L'email doit faire au maximum 100 caractères"
  }, 
  uniqueness: { case_sensitive: false },
  format: { with: VALID_EMAIL_REGEX, message: "L'email saisi n'est pas valide" }
  has_secure_password
end