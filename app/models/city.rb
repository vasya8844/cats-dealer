class City < ApplicationRecord
  class << self
    def define_city(cat_item)
      find_or_create_by name: cat_item[:location]
    end

    def select_options
      order(:name).map { |city| [city.name, city.id] }
    end
  end
end
