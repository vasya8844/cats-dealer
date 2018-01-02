class CreateCatItems < ActiveRecord::Migration[5.1]
  def change
    create_table :cat_items do |t|
      t.integer :city_id, null: false
      t.integer :cat_category_id, null: false
      t.integer :price, null: false
      t.string :image

      t.string :source, null: false

      t.timestamps
    end
    add_index :cat_items, :city_id
    add_index :cat_items, :cat_category_id
    add_index :cat_items, :source
  end
end
