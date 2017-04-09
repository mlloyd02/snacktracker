class Snack < ActiveRecord::Base

  BASE_URL = 'https://api-snacks.nerderylabs.com'
  API_KEY = '2bc3457a-bdfd-45f7-8083-5fab09d408f9'

  def fetch_data
    url = BASE_URL + '/v1/snacks/?ApiKey=' + API_KEY
    response = Faraday.get url
    data = JSON.parse response.body
  end

  def get_optional
    optional = fetch_data.select { |snack| snack["optional"] }
  end

  def get_required
    required = fetch_data.select { |snack| !snack["optional"] }
  end

end
