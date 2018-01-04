module CatItemSynchronizer
  module CatsApi
    class AmazonawsXML < Base
      def source_key
        :amazon_xml
      end

      def cat_items
        cat_nodes = rich_resource
        raise IOError, 'Got empty xml' unless cat_nodes.count.positive?

        cat_nodes.collect do |cat_node|
          cat_node.xpath('*').map do |cat_attr|
            [cat_attr.name, cat_attr.text]
          end.to_h
        end
      end

      protected

      def resource_url
        'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml'
      end

      private

      def rich_resource
        doc = Nokogiri::XML(extract)
        doc.xpath('cats/cat')
      end
    end
  end
end
