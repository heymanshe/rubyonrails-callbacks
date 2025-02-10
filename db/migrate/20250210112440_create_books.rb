class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title
      t.decimal :weight_in_pounds
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
