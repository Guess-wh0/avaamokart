require 'csv'

class CreateUserOrderHistoryJob < ApplicationJob
  sidekiq_options retry: 3

  def perform(user_id)
    user = User.find(user_id)
    orders = user.orders.left_joins(:product).select('products.code as product_code', 'products.name as product_name', 'products.category as product_category', 'orders.order_date')

    csv_data = CSV.generate(headers: true) do |csv|
      csv << ['USERNAME', 'USER_EMAIL', 'PRODUCT_CODE', 'PRODUCT_NAME', 'PRODUCT_CATEGORY', 'ORDER_DATE']

      orders.each do |order|
        csv << [user.name, user.email, order.product_code, order.product_name, order.product_category, order.order_date]
      end
    end

    file_path = Rails.root.join("tmp/#{user.id}_orders.csv")
    File.write(file_path, csv_data)
  end
end
