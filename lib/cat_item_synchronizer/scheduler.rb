module CatItemSynchronizer
  class Scheduler
    CAT_SOURCES = [CatsApi::AmazonawsJSON, CatsApi::AmazonawsXML].freeze

    class << self
      def run
        CAT_SOURCES.each do |source|
          process_source(source.new)
        end
      end

      private

      def process_source(source_inst)
        CatItem.persist_items(source_inst.cat_items, source_inst.source_key)
      end
    end
  end
end
