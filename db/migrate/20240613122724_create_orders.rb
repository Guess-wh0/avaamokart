class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :user_email, index: true
      t.string :product_code, index: true
      t.datetime :order_date

      t.timestamps
    end
  end
end
