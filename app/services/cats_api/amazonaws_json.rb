class CatsApi::AmazonawsJSON
  URL = 'https://nh7b1g9g23.execute-api.us-west-2.amazonaws.com/dev/cats/json'

  def perform
    response = RestClient.get(URL)
    JSON.parse(response)
  end
end