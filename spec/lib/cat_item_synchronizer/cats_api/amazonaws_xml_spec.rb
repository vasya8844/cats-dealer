require 'rails_helper'

describe CatItemSynchronizer::CatsApi::AmazonawsXML do
  describe 'return objects' do
    let(:cats) { described_class.new.cat_items }

    before do
      allow(RestClient).to receive(:get).and_return file_fixture('cats.xml').read
    end
    it 'return list of objects' do
      expect(cats.count).to eq 4
    end

    it 'returned hash has collection of keys' do
      expect(cats.first.keys).to eq %w[name price location image]
    end
  end

  it 'raise error when incorrect xml' do
    allow(RestClient).to receive(:get).and_return ''
    expect { described_class.new.cat_items }.to raise_error IOError
  end
end
