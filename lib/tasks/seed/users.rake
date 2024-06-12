namespace :seed do
  desc 'seed users ---bundle exec rake seed:users---'

  task users: :environment do

    puts "Starting Seed Users task at #{ Time.current }"

    require 'csv'

    csv_file_path = Rails.root.join('db', 'seeds', 'users.csv')

    if File.exist?(csv_file_path)
      puts "Seeding users from #{csv_file_path}..."

      batch_size = 1000
      users = []
      users_size = 0

      CSV.foreach(csv_file_path, headers: true) do |row|
        if row['USERNAME'].present? && row['EMAIL'].present?
          users << {
            name: row['USERNAME'],
            email: row['EMAIL'],
            number: row['PHONE'],
            created_at: Time.now,
            updated_at: Time.now
          }
          users_size += 1
        end

        if users_size >= batch_size
          User.insert_all(users)
          users = []
          users_size = 0
        end
      end

      # Insert any remaining users
      User.insert_all(users) unless users.empty?

      puts "Seeding completed successfully!"
    else
      puts "CSV file not found: #{csv_file_path}"
    end
    puts "Ending Seed Users task at #{ Time.current }"
  end
end
