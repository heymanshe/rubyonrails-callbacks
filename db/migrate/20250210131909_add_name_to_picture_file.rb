class AddNameToPictureFile < ActiveRecord::Migration[8.0]
  def change
    add_column :picture_files, :name, :string
  end
end
