require 'rails_helper'

describe CatCategory, type: :model do
  let(:cat_item_params) do
    {name: 'Sphynx'}
  end

  it 'return when exists in db' do
    category = create(:cat_category, name: cat_item_params[:name])
    expect(CatCategory.define_category(cat_item_params).id).to eq category.id
  end

  it 'create and return when name not exists' do
    category = CatCategory.define_category(cat_item_params)
    expect(category).to be_persisted
  end
end
