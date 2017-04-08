class Snack < ActiveRecord::Base

  BASE_URL = 'https://api-snacks.nerderylabs.com'

  def initialize
  end

  def fetch_data
    url = 'https://api-snacks.nerderylabs.com/v1/snacks/?ApiKey=2bc3457a-bdfd-45f7-8083-5fab09d408f9'
    response = Faraday.get url
    data = JSON.parse response.body
  end


end
