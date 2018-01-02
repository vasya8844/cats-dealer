class AddCityAndCategoryIndex < ActiveRecord::Migration[5.1]
  def change
    add_index :cat_items, [:city_id, :cat_category_id]
  end
end
