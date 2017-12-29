module CatsApi
  class AmazonawsXML
    URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/xml'

    def perform
      response = RestClient.get(URL)
      Hash.from_xml(response)['cats']['cat']
    end
  end
end