module CatItemSynchronizer
  class Scheduler
    CAT_SOURCES = [CatsApi::AmazonawsJSON, CatsApi::AmazonawsXML]

    def self.run
      CAT_SOURCES.each do |source|
        source_inst = source.new
        CatItem.persist_items(source_inst.cat_items, source_inst.source_key)
      end
    end
  end
end