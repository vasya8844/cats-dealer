require 'rails_helper'

describe CatItemSynchronizer::Scheduler do
  let(:source_inst) { spy('api_source_inst') }

  it 'invoke cat_items on api sources' do
    allow(source_inst).to receive(:source_key).and_return []
    described_class.send(:process_source, source_inst)

    expect(source_inst).to have_received(:cat_items)
  end
end
