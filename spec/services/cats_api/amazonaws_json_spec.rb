require 'rails_helper'

describe CatsApi::AmazonawsJSON do
  it 'parse and return array of objects' do
    allow(RestClient).to receive(:get).and_return file_fixture('cats.json').read
    cats = described_class.new.perform
    expect(cats.count).to eq 3
    expect(cats.first.keys).to eq %w(name price location image)
  end
end
