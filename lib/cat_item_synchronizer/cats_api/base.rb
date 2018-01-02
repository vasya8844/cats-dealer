module CatItemSynchronizer::CatsApi
  class Base
    def source_key
      raise 'to be defined'
    end

    protected

    def resource_url
      raise 'to be defined'
    end

    def extract
      RestClient.get resource_url
    end
  end
end