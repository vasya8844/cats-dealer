require 'rails_helper'

describe CatItemSynchronizer::Scheduler do
  it 'invoke cat_items from api sources' do
    expect_any_instance_of(CatItemSynchronizer::CatsApi::AmazonawsJSON).to receive(:cat_items).and_return []
    expect_any_instance_of(CatItemSynchronizer::CatsApi::AmazonawsXML).to receive(:cat_items).and_return []
    described_class.run
  end
end
