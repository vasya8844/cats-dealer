class CreateCatCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :cat_categories do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :cat_categories, :name
  end
end
