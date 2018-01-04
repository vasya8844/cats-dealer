require 'rails_helper'

describe City, type: :model do
  let(:cat_item_params) do
    {location: 'Lviv'}
  end

  it 'return when exists in db' do
    city = create(:city, name: cat_item_params[:location])
    expect(City.define_city(cat_item_params).id).to eq city.id
  end

  it 'create and return when name not exists' do
    city = City.define_city(cat_item_params)
    expect(city).to be_persisted
  end
end
