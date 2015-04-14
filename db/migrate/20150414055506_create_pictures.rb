class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :picture
      t.references :book, index: true
      t.references :request, index: true

      t.timestamps null: false
    end
    add_foreign_key :pictures, :books
    add_foreign_key :pictures, :requests
  end
end
