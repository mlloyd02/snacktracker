class Suggestion < ActiveRecord::Base

  BASE_URL = 'https://api-snacks.nerderylabs.com'
  API_KEY = '2bc3457a-bdfd-45f7-8083-5fab09d408f9'

  attr_accessor :name, :location

  def after_initialize(name, location)
    @name = name
    @location = location
  end

  def send
    conn = Faraday.new(:url => BASE_URL)

    response = conn.post do |req|
      req.url '/v1/snacks/?ApiKey=' + API_KEY
      req.headers['Content-Type'] = 'application/json'
      req.body = { :name => @name, :location => @location }.to_json
    end
  end

end
