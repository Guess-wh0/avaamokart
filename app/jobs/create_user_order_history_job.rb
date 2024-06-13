class CreateUserOrderHistoryJob < ApplicationJob
  include Sidekiq::Job

  sidekiq_options retry: 3

  def perform(user_id)
    user = User.find(user_id)
    orders = user.orders.includes(:products).select('user.name as user_name', 'user.email as email', 'product.code as product_code', 'product.name as product_name', 'product.category as product_category', 'order_date')

    csv_data = CSV.generate(headers: true) do |csv|
      csv << ['USERNAME', 'USER_EMAIL', 'PRODUCT_CODE', 'PRODUCT_NAME', 'PRODUCT_CATEGORY', 'ORDER_DATE']

      orders.each do |order|
        csv << [order.username, order.email, order.product_code, order.product_name, order.product_category, order.order_date]
      end
    end

    file_path = Rails.root.join("tmp/#{user.id}_orders.csv")
    File.write(file_path, csv_data)
  end
end
