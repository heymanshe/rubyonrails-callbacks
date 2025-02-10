class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.boolean :author_trusted
      t.boolean :parental_control_enabled

      t.timestamps
    end
  end
end
