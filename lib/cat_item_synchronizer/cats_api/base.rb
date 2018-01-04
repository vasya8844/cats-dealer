module CatItemSynchronizer
  module CatsApi
    class Base
      def source_key
        raise 'to be defined'
      end

      protected

      def resource_url
        raise 'to be defined'
      end

      def extract
        rest_client.get resource_url
      end

      def rest_client
        RestClient
      end
    end
  end
end
