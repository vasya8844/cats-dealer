require 'rails_helper'

describe CatsController, type: :controller do
  def create_item(city, category)
    CatItem.create price: Faker::Base.rand_in_range(10, 200),
                   image: Faker::Internet.url,
                   source: 'some_source',
                   city: city, cat_category: category
  end

  def response_cat_items
    response.body.scan(/<tr.*cat_item/)
  end

  describe 'index' do
    render_views

    let(:city1) { create(:city, name: Faker::Address.city) }
    let(:city2) { create(:city, name: Faker::Address.city) }
    let(:cat_category1) { create(:cat_category, name: Faker::Lorem.character) }
    let(:cat_category2) { create(:cat_category, name: Faker::Lorem.character) }

    let!(:cat_item11) { create_item(city1, cat_category1) }
    let!(:cat_item12) { create_item(city1, cat_category2) }
    let!(:cat_item21) { create_item(city2, cat_category1) }
    let!(:cat_item22) { create_item(city2, cat_category2) }

    it 'returns status 200' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'display all cat item' do
      get :index
      expect(response_cat_items.count).to eq 4
    end

    it 'filter by city' do
      get :index, params: {city: [city1.id]}
      expect(response_cat_items.count).to eq 2
    end
    it 'filter by category' do
      get :index, params: {cat_category: [cat_category1.id]}
      expect(response_cat_items.count).to eq 2
    end

    it 'filter by city and category' do
      get :index, params: {city: [city1.id], cat_category: [cat_category1.id]}
      expect(response_cat_items.count).to eq 1
    end

    context 'when no items' do
      before do
        get :index, params: {city: [city1.id + city2.id]}
      end

      it 'display no items' do
        expect(response_cat_items.count).to eq 0
      end

      it 'display no items label' do
        expect(response.body).to match(/Sorry, no cats for your location/)
      end
    end

    it 'show best price' do
      get :index

      best_price = [cat_item11, cat_item12, cat_item21, cat_item22].collect(&:price).min
      expect(response.body).to match(/Best price for your options: #{best_price}/)
    end
  end
end
