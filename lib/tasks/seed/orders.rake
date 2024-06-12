namespace :seed do
  desc 'seed orders ---bundle exec rake seed:orders---'

  task orders: :environment do

    puts "Starting Seed Orders task at #{ Time.current }"

    require 'csv'

    csv_file_path = Rails.root.join('db', 'seeds', 'order_details.csv')

    if File.exist?(csv_file_path)
      puts "Seeding Orders from #{csv_file_path}..."

      batch_size = 1000
      orders = []
      orders_size = 0

      CSV.foreach(csv_file_path, headers: true) do |row|
        orders << {
          user_email: row['USER_EMAIL'],
          product_code: row['PRODUCT_CODE'],
          order_date: DateTime.strptime(row['ORDER_DATE'], '%Y-%m-%d'),
          created_at: Time.now,
          updated_at: Time.now
        }
        orders_size += 1

        if orders_size >= batch_size
          Order.insert_all(orders)
          orders = []
          orders_size = 0
        end
      end

      # Insert any remaining orders
      Order.insert_all(orders) unless orders.empty?

      puts "Seeding completed successfully!"
    else
      puts "CSV file not found: #{csv_file_path}"
    end
    puts "Ending Seed Orders task at #{ Time.current }"
  end
end
