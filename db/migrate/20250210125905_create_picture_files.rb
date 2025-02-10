class CreatePictureFiles < ActiveRecord::Migration[8.0]
  def change
    create_table :picture_files do |t|
      t.string :filepath
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
