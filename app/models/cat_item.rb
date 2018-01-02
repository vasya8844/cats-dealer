class CatItem < ApplicationRecord
  belongs_to :cat_category
  belongs_to :city

  class << self
    def filter(city, category)
      result = all

      result = result.where('city_id in (?)', city) if city
      result = result.where('cat_category_id in (?)', category) if category

      result = result.includes(:city, :cat_category)
      result = result.order(:price)

      result
    end

    def persist_items(cat_items, source_key)
      transaction do
        where(source: source_key).destroy_all

        cat_items.each do |cat_item|
          cat_item.symbolize_keys!
          category = CatCategory.define_category(cat_item)
          city = City.define_city(cat_item)
          persist_item(cat_item, category, city, source_key)
        end
      end
    end

    private

    def persist_item(cat_item, cat_category, city, source)
      cat_params = {city: city, cat_category: cat_category, source: source}
      cat_params.merge! cat_item.slice(:price, :image)
      create! cat_params
    end
  end
end
