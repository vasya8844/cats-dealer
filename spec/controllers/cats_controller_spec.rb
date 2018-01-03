require 'rails_helper'

describe CatsController, type: :controller do
  def create_item(city, category)
    CatItem.create price: Faker::Base.rand_in_range(10, 200),
                   image: Faker::Internet.url,
                   source: 'some_source',
                   city: city, cat_category: category
  end

  def response_cat_items
    response.body.scan /\<tr.*cat_item/
  end

  describe 'index' do
    render_views

    before do
      @city1 = create(:city, name: Faker::Address.city)
      @city2 = create(:city, name: Faker::Address.city)
      @cat_category1 = create(:cat_category, name: Faker::Lorem.character)
      @cat_category2 = create(:cat_category, name: Faker::Lorem.character)

      @cat_item_11 = create_item @city1, @cat_category1
      @cat_item_12 = create_item @city1, @cat_category2
      @cat_item_21 = create_item @city2, @cat_category1
      @cat_item_22 = create_item @city2, @cat_category2
    end

    it 'display all cat item' do
      get :index
      expect(response.status).to eq(200)

      expect(response_cat_items.count).to eq 4
    end

    it 'filter by city' do
      get :index, params: {city: [@city1.id]}
      expect(response.status).to eq(200)

      expect(response_cat_items.count).to eq 2
    end
    it 'filter by category' do
      get :index, params: {cat_category: [@cat_category1.id]}
      expect(response.status).to eq(200)

      expect(response_cat_items.count).to eq 2
    end

    it 'filter by city and category' do
      get :index, params: {city: [@city1.id], cat_category: [@cat_category1.id]}
      expect(response.status).to eq(200)

      expect(response_cat_items.count).to eq 1
    end

    it 'display no item' do
      get :index, params: {city: [@city1.id + @city2.id]}
      expect(response.status).to eq(200)

      expect(response_cat_items.count).to eq 0
      expect(response.body).to match /Sorry, no cats for your location/
    end

    it 'show best price' do
      get :index

      best_price = [@cat_item_11, @cat_item_12, @cat_item_21, @cat_item_22].collect { |i| i.price }.min
      expect(response.body).to match /Best price for your options: #{best_price}/
    end
  end
end
