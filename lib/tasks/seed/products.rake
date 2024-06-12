namespace :seed do
  desc 'seed products ---bundle exec rake seed:products---'

  task products: :environment do

    puts "Starting Seed Products task at #{ Time.current }"

    require 'csv'

    csv_file_path = Rails.root.join('db', 'seeds', 'products.csv')

    if File.exist?(csv_file_path)
      puts "Seeding Products from #{csv_file_path}..."

      batch_size = 1000
      products = []
      products_size = 0

      CSV.foreach(csv_file_path, headers: true) do |row|
        products << {
          name: row['NAME'],
          code: row['CODE'],
          category: row['CATEGORY'],
          created_at: Time.now,
          updated_at: Time.now
        }
        products_size += 1

        if products_size >= batch_size
          Product.insert_all(products)
          products = []
          products_size = 0
        end
      end

      # Insert any remaining products
      Product.insert_all(products) unless products.empty?

      puts "Seeding completed successfully!"
    else
      puts "CSV file not found: #{csv_file_path}"
    end
    puts "Ending Seed Products task at #{ Time.current }"
  end
end
