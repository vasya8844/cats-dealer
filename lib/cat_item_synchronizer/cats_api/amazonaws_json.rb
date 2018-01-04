module CatItemSynchronizer
  module CatsApi
    class AmazonawsJSON < Base
      def source_key
        :amazon_json
      end

      def cat_items
        JSON.parse extract
      end

      protected

      def resource_url
        'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json'
      end
    end
  end
end
