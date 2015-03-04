module RailsUpgradeTracker
  ENDPOINT = "https://rubygems.org/api/v1/"

  class Base
    def self.rails_data(version)
      client = Hurley::Client.new(ENDPOINT)
      response = client.get("versions/rails.json")
      data = JSON.parse(response.body).find { |r| r['number'] == version }
      data
    end
  end
end
