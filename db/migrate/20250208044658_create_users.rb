class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :location
      t.string :role
      t.string :password

      t.timestamps
    end
  end
end
