class ApiService

  BASE_URL = Rails.application.secrets.base_url
  API_KEY = Rails.application.secrets.api_key

  def self.post_new_snack(name, location)
    conn = Faraday.new(:url => BASE_URL)

    response = conn.post do |req|
      req.url '/v1/snacks/?ApiKey=' + API_KEY
      req.headers['Content-Type'] = 'application/json'
      req.body = { :name => name, :location => location }.to_json
    end
    response_body_parsed response
  end

  def self.fetch_data
    url = BASE_URL + '/v1/snacks/?ApiKey=' + API_KEY
    response = Faraday.get url
  end

  def self.response_body_parsed response
    body_parsed = JSON.parse response.body
  end

  #updates existing or creates new snacks in the database based on what we get from API
  def self.sync_db response
    api_snacks = optional_snacks response
    api_snacks.each do |snack|
      s = OptionalSnack.find_or_initialize_by(api_id: snack["id"])
      s.name = snack["name"]
      s.last_purchase_date = snack["lastPurchaseDate"]
      s.save
    end
  end

  def self.optional_snacks response
    optional = response_body_parsed(response).select { |snack| snack["optional"] }
  end

  def self.required_snacks response
    required = response_body_parsed(response).select { |snack| !snack["optional"] }
  end

  def self.error_message
    "There appears to be an issue connecting to the API. Please come back soon to cast your votes and make suggestions!"
  end

end
