class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, index: true
      t.string :number

      t.timestamps
    end
  end
end
