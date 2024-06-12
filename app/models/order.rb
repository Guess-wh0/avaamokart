class Order < ApplicationRecord
  # Validations
  with_options presence: true do
    validates :user_email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, allow_nil: true }
    validates :product_code, format: { with: /\AP[0-9]+\z/ }
    validates :order_date
  end

  # Associations
  belongs_to :user, foreign_key: 'user_email', primary_key: 'email'
  belongs_to :product, foreign_key: 'product_code', primary_key: 'code'
end
