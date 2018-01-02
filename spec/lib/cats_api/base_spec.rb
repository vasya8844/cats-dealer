require 'rails_helper'

describe CatItemSynchronizer::CatsApi::Base do
  let(:site_url) { 'http://some-site.com' }

  before do
    @obj = described_class.new
    allow(@obj).to receive(:resource_url).and_return site_url
  end

  it 'invoke rest client' do
    expect(RestClient).to receive(:get).with(site_url)
    @obj.send :extract
  end
end
