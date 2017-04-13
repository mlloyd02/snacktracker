class ApiService

  BASE_URL = 'https://api-snacks.nerderylabs.com'
  API_KEY = '2bc3457a-bdfd-45f7-8083-5fab09d408f9'

  def self.post_new_snack(name, location)
    conn = Faraday.new(:url => BASE_URL)

    response = conn.post do |req|
      req.url '/v1/snacks/?ApiKey=' + API_KEY
      req.headers['Content-Type'] = 'application/json'
      req.body = { :name => name, :location => location }.to_json
    end
  end

  def self.fetch_data
    url = BASE_URL + '/v1/snacks/?ApiKey=' + API_KEY
    response = Faraday.get url
    data = JSON.parse response.body
  end

  def self.sync_db
    api_snacks = get_optional
    api_snacks.each do |snack|
      s = OptionalSnack.find_or_initialize_by(api_id: snack["id"])
      s.name = snack["name"]
      s.last_purchase_date = snack["lastPurchaseDate"]
      s.save
    end
  end

  def self.get_optional
    optional = fetch_data.select { |snack| snack["optional"] }
  end

  def self.get_required
    required = fetch_data.select { |snack| !snack["optional"] }
  end

end
