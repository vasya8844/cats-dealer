require 'rails_helper'

describe CatItemSynchronizer::CatsApi::Base do
  let(:site_url) { 'http://some-site.com' }
  let(:api_instance) { described_class.new }
  let(:rest_client_class) { spy('rest_client_class') }

  it 'invoke rest client' do
    allow(api_instance).to receive(:resource_url).and_return site_url
    allow(api_instance).to receive(:rest_client).and_return rest_client_class

    api_instance.send :extract
    expect(rest_client_class).to have_received(:get).with(site_url)
  end
end
