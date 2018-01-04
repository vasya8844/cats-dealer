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
    cat_item_obj_params.slice(:price, :image).dup.tap do |p|
      p[:name] = cat_category.name
      p[:location] = city.name
    end
  end

  before do
    CatItem.create cat_item_obj_params.merge(source: :source_one)
    CatItem.create cat_item_obj_params.merge(source: :source_two)
    CatItem.create cat_item_obj_params.merge(source: cat_source)
  end

  describe 'persist item' do
    it 'persist items' do
      test_price = 112
      params_new = cat_item_raw_params.dup.tap { |item| item[:price] = test_price }
      CatItem.persist_items([params_new], cat_source)

      expect(CatItem.find_by(source: cat_source).price).to eq test_price
    end

    describe 'clear items by source' do
      let(:source_params) { {source: cat_source} }
      let!(:old_cat_item) { CatItem.find_by source_params }

      before do
        CatItem.persist_items [cat_item_raw_params], cat_source
      end

      it 'clear stored items' do
        expect(CatItem.where(source_params).count).to eq 1
      end

      it 'new item created' do
        expect(CatItem.find_by(source_params).id).not_to eq old_cat_item.id
      end

      it 'does not clear another source' do
        CatItem.persist_items [cat_item_raw_params], cat_source
        expect(CatItem.where.not(source: cat_source).count).to eq 2
      end
    end
  end

  describe 'filter items' do
    it 'all list' do
      expect(CatItem.filter_items(nil, nil).second.count).to eq 3
    end

    it 'filter by category' do
      params = cat_item_obj_params.dup.tap do |item|
        item[:cat_category] = create(:cat_category, name: Faker::Lorem.character)
      end
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
