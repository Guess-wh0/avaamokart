class Product < ApplicationRecord
  # Validations
  with_options presence: true do
    validates :code, uniqueness: true, format: { with: /\AP[0-9]+\z/ }
    validates :name
    validates :category, uniqueness: true
  end

  # Associations
  has_many :orders, foreign_key: 'product_code', primary_key: 'code'
end
