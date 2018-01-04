require 'rails_helper'

describe CatItemSynchronizer::CatsApi::AmazonawsJSON do
  describe 'return objects' do
    let(:cats) { described_class.new.cat_items }

    before do
      allow(RestClient).to receive(:get).and_return file_fixture('cats.json').read
    end
    it 'return all objects' do
      expect(cats.count).to eq 3
    end

    it 'returned object contains result keys' do
      expect(cats.first.keys).to eq %w[name price location image]
    end
  end

  it 'raise json parse in case incorrect data' do
    allow(RestClient).to receive(:get).and_return ''
    expect { described_class.new.cat_items }.to raise_error JSON::ParserError
  end
end
