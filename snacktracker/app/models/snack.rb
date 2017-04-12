class Snack < ActiveRecord::Base

    BASE_URL = 'https://api-snacks.nerderylabs.com'
    API_KEY = '2bc3457a-bdfd-45f7-8083-5fab09d408f9'

    attr_accessor :name, :location

    def after_initialize(name, location)
      @name = name
      @location = location
    end

    def post_new_snack
      conn = Faraday.new(:url => BASE_URL)

      response = conn.post do |req|
        req.url '/v1/snacks/?ApiKey=' + API_KEY
        req.headers['Content-Type'] = 'application/json'
        req.body = { :name => @name, :location => @location }.to_json
      end
    end

    def self.fetch_data
      url = BASE_URL + '/v1/snacks/?ApiKey=' + API_KEY
      response = Faraday.get url
      data = JSON.parse response.body
    end

    def self.get_optional
      optional = fetch_data.select { |snack| snack["optional"] }
    end

    def self.get_required
      required = fetch_data.select { |snack| !snack["optional"] }
    end

end
