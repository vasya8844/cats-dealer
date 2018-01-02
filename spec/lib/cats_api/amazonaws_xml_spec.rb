require 'rails_helper'

describe CatItemSynchronizer::CatsApi::AmazonawsXML do
  context 'parse data' do
    it 'return array of objects' do
      allow(RestClient).to receive(:get).and_return file_fixture('cats.xml').read
      cats = described_class.new.cat_items
      expect(cats.count).to eq 4
      expect(cats.first.keys).to eq %w(name price location image)
    end

    it 'parse and return array of objects' do
      allow(RestClient).to receive(:get).and_return ''
      expect { described_class.new.cat_items }.to raise_error IOError
    end
  end
end
