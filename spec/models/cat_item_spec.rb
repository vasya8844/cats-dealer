require 'rails_helper'

describe CatItem, type: :model do
  let(:cat_source) { :some_sorce }
  let(:cat_category) { create(:cat_category) }
  let(:city) { create(:city) }
  let(:price) { 500 }
  let(:cat_item_obj_params) do
    {
        price: price,
        image: 'https://olxua.net/photo.jpg',
        cat_category: cat_category,
        city: city,
        source: 'source'
    }
  end

  let(:cat_item_raw_params) do
    cat_item_obj_params.slice(:price, :image).dup.tap { |p|
      p[:name] = cat_category.name
      p[:location] = city.name
    }
  end

  before do
    CatItem.create cat_item_obj_params.merge(source: :source_one)
    CatItem.create cat_item_obj_params.merge(source: :source_two)
    CatItem.create cat_item_obj_params.merge(source: cat_source)
  end

  describe 'persist item' do
    it 'persist items' do
      test_price = 112
      params_new = cat_item_raw_params.dup.tap { |item|
        item[:price] = test_price
      }
      CatItem.persist_items([params_new], cat_source)

      new_cat_item = CatItem.find_by(source: cat_source)
      expect(new_cat_item.price).to eq test_price
    end

    it 'clear items by source' do
      source_params = {source: cat_source}
      cat_item = CatItem.find_by source_params

      CatItem.persist_items [cat_item_raw_params], cat_source

      expect(CatItem.where(source_params).count).to eq 1
      expect(CatItem.find_by(source_params).id).to_not eq cat_item.id
    end

    it 'does not clear by another source' do
      CatItem.persist_items [cat_item_raw_params], cat_source
      expect(CatItem.where.not(source: cat_source).count).to eq 2
    end
  end

  describe 'filter items' do
    it 'all list' do
      expect(CatItem.filter_items(nil, nil).second.count).to eq 3
    end

    it 'filter by category' do
      params = cat_item_obj_params.dup.tap { |item|
        item[:cat_category] = create(:cat_category, name: Faker::Lorem.character)
      }
      CatItem.create params
      expect(CatItem.filter_items(nil, [params[:cat_category].id]).second.count).to eq 1
    end

    it 'define best price' do
      params = cat_item_obj_params.dup.tap { |item| item[:price] = 12 }
      CatItem.create params
      expect(CatItem.filter_items(nil, [params[:cat_category].id]).first).to eq 12
    end
  end
end
