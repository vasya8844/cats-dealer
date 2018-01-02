class CatCategory < ApplicationRecord
  class << self
    def define_categoary(cat_item)
      find_or_create_by name: cat_item[:name]
    end

    def select_options
      order(:name).map { |city| [city.name, city.id] }
    end
  end
end
