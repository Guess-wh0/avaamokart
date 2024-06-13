class User < ApplicationRecord
  # Validations
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :number, format: { with: /\A[0-9-]+\z/ }
  validates :name, presence: true

  # Associations
  has_many :orders, foreign_key: 'user_email', primary_key: 'email'
end
