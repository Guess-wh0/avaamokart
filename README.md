ruby '3.1.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'

* Ruby version 3.1.0
* Sqlite
* Redis-Server

*bundle install
*yarn install

**Seed Commands**
rails seed:users
rails seed:products
rails seed:orders

**Servers**
./bin/webpack-dev-server
rails s
redis-server
bundle exec sidekiq

**Can Be Worked On**
Name of file downloaded
Batch creation of csv files
Deletion of files after time interval